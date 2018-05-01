class AddJobToJobApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :job_applications, :job, :integer
  end
end
