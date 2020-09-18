class Help < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  # validates :child_id, presence: { message: "を選択してください"}
  
  # belongs_to :parent
  belongs_to :child
end
