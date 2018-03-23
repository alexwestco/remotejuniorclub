class AddAttachmentProfileImageToDevelopers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :developers do |t|
      t.attachment :profile_image
    end
  end

  def self.down
    remove_attachment :developers, :profile_image
  end
end
