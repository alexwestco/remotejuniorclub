class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :developer
      t.text :body

      t.timestamps
    end
  end
end
