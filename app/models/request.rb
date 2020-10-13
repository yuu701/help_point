class Request < ApplicationRecord
  validates :request_date, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  validates :status, inclusion: { in:[true, false] }
  
  belongs_to :parent
  belongs_to :child
  has_one :apply, dependent: :destroy
end
