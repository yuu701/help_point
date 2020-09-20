class Request < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  
  belongs_to :parent
  belongs_to :child
end
