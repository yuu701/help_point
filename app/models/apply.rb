class Apply < ApplicationRecord
  validates :close, inclusion: { in:[true, false] }
  validates :completion_date, presence: true
  
  belongs_to :request
  
  # def closed
  #   self.close
  # end
end
