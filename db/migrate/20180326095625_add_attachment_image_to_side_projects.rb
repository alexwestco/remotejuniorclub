class AddAttachmentImageToSideProjects < ActiveRecord::Migration[5.1]
  def self.up
    change_table :side_projects do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :side_projects, :image
  end
end
