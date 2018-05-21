class JobsController < ApplicationController
  def index
    @jobs = Job.all
    @jobs_uniq_name = Job.select(:name).distinct
  end
end
