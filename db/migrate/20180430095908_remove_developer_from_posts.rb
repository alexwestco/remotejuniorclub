class RemoveDeveloperFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :developer, :integer
  end
end
