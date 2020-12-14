class Apply < ApplicationRecord
  validates :close, inclusion: { in:[true, false] }
  validates :completion_date, presence: true
  
  belongs_to :request
  has_one :result, dependent: :destroy
  has_one :child, through: :request
  
  # def closed
  #   self.close
  # end
  
  def create_apply(create_apply_date)
    self.comment = ""
    self.completion_date = create_apply_date
    self.close = true
  end
end
