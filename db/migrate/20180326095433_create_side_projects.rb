class CreateSideProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :side_projects do |t|
      t.string :name
      t.text :description
      t.string :github_repo
      t.string :website

      t.timestamps
    end
  end
end
