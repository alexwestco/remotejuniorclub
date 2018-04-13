class AddCVcounterToDevelopers < ActiveRecord::Migration[5.1]
  def change
    add_column :developers, :CV_counter, :integer
  end
end
