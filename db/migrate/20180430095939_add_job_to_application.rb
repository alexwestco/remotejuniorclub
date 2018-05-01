class AddJobToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :job, :integer
  end
end
