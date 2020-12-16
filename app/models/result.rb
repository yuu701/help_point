class Result < ApplicationRecord
  validates :completion_date, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 255 }
  validates :point, presence: true
  validates :bonus, presence: true
  
  belongs_to :parent
  belongs_to :child
  belongs_to :apply
  
  def start_time
    self.completion_date
  end
  
  def create_result(apply)
    self.child_id = apply.request.child_id
    self.appeal_comment = apply.comment
    self.apply_id = apply.id
  end
end
