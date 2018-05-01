class AddApplicationToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :application, :integer
  end
end
