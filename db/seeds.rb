# frozen_string_literal: true

require 'jenkins_api_client'
require 'date'

filtered_jobs = []

module JenkinsClient
  @client = JenkinsApi::Client.new(YAML.load_file(File.join(__dir__, '../config/credentials_jenkins.yml')))
  config = YAML.load_file(File.join(__dir__, '../config/jobs_jenkins.yml'))
  LIST_JOBS = config['jenkins_jobs']
  def self.filtered_jobs_from_yml(jobs)
    @client.job.list_all.each do |job|
      LIST_JOBS.each do |list_job|
        jobs.push(job) if job == list_job
      end
    end
  end

  def self.timestamp_and_build_date(build_details)
    [build_details['timestamp'], Time.at(build_details['timestamp'] / 1000).to_datetime.to_s.split('+') [0]]
  end

  def self.save_data(filtered_jobs)
    filtered_jobs.each do |job_name|
      builds = @client.job.get_builds(job_name)
      builds.each do |build|
        # skip first build if not complete
        next if build['number'] == @client.job.get_current_build_number(job_name) && @client.job.get_current_build_status(job_name) == 'running'
        begin
          json_resp = @client.api_get_request("/job/#{job_name}/#{build['number']}/testReport/")
          tests_failed = json_resp['failCount']
          build_timestamp, build_date = timestamp_and_build_date(@client.job.get_build_details(job_name, build['number']))
          Job.find_or_create_by(name: job_name.to_s, build: build['number'].to_i, tests_failed: tests_failed.to_i, build_date: build_date, build_timestamp: build_timestamp, build_url: build['url'])
        rescue JenkinsApi::Exceptions::NotFound
          puts 'testReport not found. skipping'
        end
      end
    end
  end
end

JenkinsClient.filtered_jobs_from_yml(filtered_jobs)
JenkinsClient.save_data(filtered_jobs)
