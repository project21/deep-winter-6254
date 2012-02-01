class Product < ActiveRecord::Base
      has_many :tokens
	mount_uploader :image, ImageUploader
end
