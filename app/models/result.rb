class Result < ApplicationRecord
  validates :completion_date, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  
  belongs_to :parent
  belongs_to :child
  
  def start_time
    self.completion_date
  end
end
