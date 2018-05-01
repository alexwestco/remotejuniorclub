class AddCreatorToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :creator, :integer
  end
end
