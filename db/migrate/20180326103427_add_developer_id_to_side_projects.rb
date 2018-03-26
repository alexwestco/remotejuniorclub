class AddDeveloperIdToSideProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :side_projects, :developer_id, :integer
  end
end
