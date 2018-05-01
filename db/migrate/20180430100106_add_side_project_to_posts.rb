class AddSideProjectToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :side_project, :integer
  end
end
