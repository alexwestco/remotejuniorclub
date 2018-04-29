class ChangeDefaultValueOnDeveloperPoints < ActiveRecord::Migration[5.1]
  def change
  	change_column :developers, :points, :integer, :default => 0
  end
end
