class Parent < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  
  VARID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VARID_EMAIL_REGEX }
  
  # VARID_PASSWORD_REGEX = /\A(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\z/
  # validates :password, presence: true, length: { minimum: 8, maximum: 32 }, format: { with: VARID_PASSWORD_REGEX } 
  
  # has_secure_password
end
