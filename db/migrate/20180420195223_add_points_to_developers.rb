class AddPointsToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :points, :integer
  end
end
