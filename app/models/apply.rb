class Apply < ApplicationRecord
  validates :close, inclusion: { in:[true, false] }
  
  belongs_to :request
end
