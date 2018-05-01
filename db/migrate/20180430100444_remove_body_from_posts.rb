class RemoveBodyFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :body, :text
  end
end
