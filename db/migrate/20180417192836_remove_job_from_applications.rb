class RemoveJobFromApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :job, :string
  end
end
