class Child < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  
  validates :login_id, presence: true, length: { maximum: 255 },
            uniqueness: { case_sensitive: false }
  
  VALID_PASSWORD_REGEX = /\A(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\z/
  validates :password, presence: true, length: { minimum: 8 }, allow_nil:true,
            format: { with: VALID_PASSWORD_REGEX } 
  
  has_secure_password
  
  belongs_to :parent
  has_many :helps, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :applies, through: :requests
  has_many :results, dependent: :destroy
  
  def not_closed_applies
    applies.where(close: false)
  end
  
  def on_requests
    requests.where(status: false)
  end
  
  def match_completion_date
    results.where(completion_date: @date)
  end
end
