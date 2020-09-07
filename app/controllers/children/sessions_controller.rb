class Children::SessionsController < ApplicationController
  
  def create
    child = Child.find_by(login_id: params[:session][:login_id])
    if child && child.authenticate(params[:session][:password])
      log_in child
      redirect_to root_path, success: "ログインに成功しました"
    else
      flash.now[:dander] = "ログインに失敗しました"
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_path, info: "ログアウトしました"
  end
  
  private
  def log_in(child)
    session[:child_id] = child.id
  end
  
  def log_out
    session.delete(:child_id)
    @current_child = nil
  end
  
end
