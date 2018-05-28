class JobsController < ApplicationController
  def index
    @jobs = Job.all
    @jobs_uniq_name = Job.select(:name).distinct
    @ordered_tests_result_by_jobname = Hash.new
    @jobs_uniq_name.each do |job|
      job_name = job['name']
      @ordered_tests_result_by_jobname[job_name] = Job.where("name = ?", job['name']).order(:build_timestamp).pluck(:build_timestamp, :tests_failed, :build_date)
    end
  end
end
