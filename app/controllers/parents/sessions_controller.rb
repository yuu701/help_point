class Parents::SessionsController < ApplicationController
  def new
  end
  
  def create
    parent = Parent.find_by(email: params[:session][:email].downcase)
    if parent && parent.authenticate(params[:session][:password])
      log_in_parent parent
      redirect_to root_path, success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end
  
  def destroy
    log_out_parent
    redirect_to root_path, info: "ログアウトしました"
  end
  
end
