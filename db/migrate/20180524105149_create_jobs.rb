class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :name
      t.integer :build
      t.integer :tests_failed

      t.timestamps
    end
  end
end
