class SideProject < ApplicationRecord
	has_attached_file :image, :s3_protocol => :https
	validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] }
end
