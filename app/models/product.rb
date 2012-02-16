class Product < ActiveRecord::Base
      has_many :tokens
      has_many :players
	mount_uploader :image, ImageUploader
end
