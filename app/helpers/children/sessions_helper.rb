module Children::SessionsHelper
  
  def log_in(child)
    session[:child_id] = child.id
  end
  
  def current_child
    @current_child ||=Child.find_by(id: session[:child_id])
  end
  
  def child_logged_in?
    !current_child.nil?
  end
  
  def log_out
    session.delete(:child_id)
    @current_child = nil
  end
end
