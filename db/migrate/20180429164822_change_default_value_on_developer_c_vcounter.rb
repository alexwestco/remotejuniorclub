class ChangeDefaultValueOnDeveloperCVcounter < ActiveRecord::Migration[5.1]
  def change
  	change_column :developers, :CV_counter, :integer, :default => 0
  end
end
