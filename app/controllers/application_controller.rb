class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  add_flash_types :success, :info, :warning, :dander
  
  helper_method :current_parent, :current_child, :parent_logged_in?, :child_logged_in?
  
  def current_parent
    @current_parent ||=Parent.find_by(id: session[:parent_id])
  end
  
  def current_child
    @current_child ||=Child.find_by(id: session[:child_id])
  end
  
  def parent_logged_in?
    !current_parent.nil?
  end
  
  def child_logged_in?
    !current_child.nil?
  end
end
