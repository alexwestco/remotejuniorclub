class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.integer :developer
      t.integer :job

      t.timestamps
    end
  end
end
