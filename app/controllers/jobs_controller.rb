class JobsController < ApplicationController
  def index
    @jobs = Job.all
    @jobs_uniq_name = Job.select(:name).distinct
    @ordered_tests_result_by_jobname = Hash.new
    @jobs_uniq_name.each do |job|
      @ordered_tests_result_by_jobname[job.to_s] = Job.where("name = ?", job['name']).order(:build_timestamp)
    end 
  end
end
