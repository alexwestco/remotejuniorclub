class RemoveDescriptionFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :description, :text
  end
end
