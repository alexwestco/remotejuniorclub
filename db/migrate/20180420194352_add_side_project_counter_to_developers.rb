class AddSideProjectCounterToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :side_project_counter, :integer
  end
end
