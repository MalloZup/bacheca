class AddBuildDateToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :build_date, :string
  end
end
