class AddGithubToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :github, :string
  end
end
