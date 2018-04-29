class ChangeDefaultValueOnDeveloperSideProjectsCounter < ActiveRecord::Migration[5.1]
  def change
  	change_column :developers, :side_project_counter, :integer, :default => 0
  end
end
