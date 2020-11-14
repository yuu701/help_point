class Icon < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  has_many :children
end
