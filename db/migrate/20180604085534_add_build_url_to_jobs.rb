class AddBuildUrlToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :build_url, :string
  end
end
