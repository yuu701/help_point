class Apply < ApplicationRecord
  validates :close, inclusion: { in:[true, false] }
  validates :completion_date, presence: true
  
  belongs_to :request
end
