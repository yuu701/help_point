class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  add_flash_types :success, :info, :warning, :dander
  
  helper_method :current_parent, :logged_in?
  
  def current_parent
    @current_parent ||=Parent.find_by(id: session[:parent_id])
  end
  
  def logged_in?
    !current_parent.nil?
  end
end
