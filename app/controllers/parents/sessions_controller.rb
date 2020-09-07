class Parents::SessionsController < ApplicationController
  
  def create
    parent = Parent.find_by(email: params[:session][:email].downcase)
    if parent && parent.authenticate(params[:session][:password])
      log_in parent
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
  def log_in(parent)
    session[:parent_id] = parent.id
  end
  
  def log_out
    session.delete(:parent_id)
    @current_parent = nil
  end
  
end
