class AddDeveloperToJobApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :job_applications, :developer, :integer
  end
end
