class RemoveJobFromApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :job, :integer
  end
end
