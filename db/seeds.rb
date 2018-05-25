# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'jenkins_api_client'

filtered_jobs = []

module JenkinsClient
  @client = JenkinsApi::Client.new(YAML.load_file(File.join(__dir__, 'login_jenkins.yml')))
  config = (YAML.load_file(File.join(__dir__, 'jobs_jenkins.yml')))
  LIST_JOBS = config['jenkins_jobs']

  def self.filtered_jobs_from_yml(jobs)
    @client.job.list_all.each do |job|
      LIST_JOBS.each do |list_job|
        jobs.push(job) if job == list_job
      end
    end
  end

  def self.save_data(filtered_jobs)
    filtered_jobs.each do |job_name|
      builds = @client.job.get_builds(job_name)
      builds.each do |build|
        puts 'builds'
        puts builds
        puts "=========="
        # skip first build if not complete
        next if build['number'] == @client.job.get_current_build_number(job_name) && @client.job.get_current_build_status(job_name) == 'running'
        puts "++++++++++++++"
        puts "build detail"
        puts @client.job.get_build_details(job_name, build['number'])
        begin
          json_resp = @client.api_get_request("/job/#{job_name}/#{build['number']}/testReport/")
          tests_failed = json_resp['failCount']
          puts tests_failed
 #         Job.create(name: job_name.to_s, build: build['number'].to_i, tests_failed: tests_failed.to_i)
        rescue JenkinsApi::Exceptions::NotFound
          puts 'testReport not found. skipping'
        end
      end
    end
  end
end
JenkinsClient.filtered_jobs_from_yml(filtered_jobs)
JenkinsClient.save_data(filtered_jobs)
