module Children::SessionsHelper
  
  def log_in_child(child)
    session[:child_id] = child.id
  end
  
  def current_child
    @current_child ||=Child.find_by(id: session[:child_id])
  end
  
  def child_logged_in?
    !current_child.nil?
  end
  
  def log_out_child
    session.delete(:child_id)
    @current_child = nil
  end
  
  #beforeアクション
  # ログイン済childかどうか確認
  def logged_in_child
    unless child_logged_in?
      flash[:danger] = "子アカウントのログインが必要です"
      if parent_logged_in?
        redirect_to results_path
      else
        redirect_to children_login_path
      end
    end
  end
  
  # 渡されたmodelのchildがログイン済childであればtrueを返す
  def correct_child_for_model?(model)
    model.child == current_child
  end
end
