class Developer < ApplicationRecord
	has_attached_file :profile_image, :s3_protocol => :https
	validates_attachment :profile_image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] }
end
