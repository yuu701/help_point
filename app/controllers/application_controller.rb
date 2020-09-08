class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Parents::SessionsHelper
  include Children::SessionsHelper
  
  add_flash_types :success, :info, :warning, :dander
  
end
