class Children::SessionsController < ApplicationController
  
  def create
    child = Child.find_by(login_id: params[:session][:login_id])
    if child && child.authenticate(params[:session][:password])
      log_in_child child
      redirect_to results_path, success: "ログインに成功しました"
    else
      flash.now[:danger] = "ログインに失敗しました"
      render :new
    end
  end
  
  def destroy
    log_out_child
    redirect_to root_path, info: "ログアウトしました"
  end
  
end
