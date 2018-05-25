class AddBuildTimestampToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :build_timestamp, :bigint
  end
end
