class AddTechStackToSideProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :side_projects, :tech_stack, :string
  end
end
