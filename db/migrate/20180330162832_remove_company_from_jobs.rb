class RemoveCompanyFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :company, :string
  end
end
