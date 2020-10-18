module Parents::SessionsHelper
  
  # 渡されたparentをログイン
  def log_in_parent(parent)
    session[:parent_id] = parent.id
  end
  
  def current_parent
    if session[:parent_id]
      @current_parent ||=Parent.find_by(id: session[:parent_id])
    end
  end
  
  # 渡されたparentがログイン済parentであればtrueを返す
  def current_parent?(parent)
    parent == current_parent
  end
  
  def parent_logged_in?
    !current_parent.nil?
  end
  
  def log_out_parent
    session.delete(:parent_id)
    @current_parent = nil
  end
  
  # 渡されたmodelのparentがログイン済parentであればtrueを返す
  def correct_parent_for_model?(model)
    model.parent == current_parent
  end
  
end
