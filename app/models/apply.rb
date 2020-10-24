class Apply < ApplicationRecord
  validates :close, inclusion: { in:[true, false] }
  validates :completion_date, presence: true
  
  belongs_to :request
  has_one :result, dependent: :destroy
  
  # def closed
  #   self.close
  # end
end
