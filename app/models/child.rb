class Child < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  
  validates :login_id, presence: true, length: { minimum: 3, maximum: 255 },
            uniqueness: { case_sensitive: false }
  
  VALID_PASSWORD_REGEX = /\A(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\z/
  validates :password, presence: true, length: { minimum: 8, maximum: 32 }, allow_nil:true,
            format: { with: VALID_PASSWORD_REGEX } 
  
  has_secure_password
  
  validates :parent_id, presence: true
  
  belongs_to :parent
end
