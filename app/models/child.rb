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
  
end
