class ParentsController < ApplicationController
  before_action :logged_in_parent, only:[:edit, :update]
  before_action :correct_parent, only:[:edit, :update]
  
  def show
  end
  
  def new
    @parent = Parent.new
  end
  
  def create
    @parent = Parent.new(parent_params)
    if @parent.save
      log_in_parent @parent
      redirect_to root_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @parent = Parent.find(params[:id])
  end
  
  def update
    @parent = Parent.find(params[:id])
    if @parent.update_attributes(parent_params)
    # if current_parent == @parent
      redirect_to results_path, success: "アカウント情報を変更しました"
    else
      flash.now[:danger] = "アカウント情報の変更に失敗しました"
      render :edit
    end
  end
  
  private
  def parent_params
    params.require(:parent).permit(:name, :email, :password, :password_confirmation)
  end
  
  # beforeアクション
  
  # ログイン済parentかどうか確認
  def logged_in_parent
    unless parent_logged_in?
      flash[:danger] = "ログインが必要です"
      redirect_to parents_login_path
    end
  end
  
  # 正しいparentかどうか確認
  def correct_parent
    @parent = Parent.find(params[:id])
    redirect_to(root_url) unless current_parent?(@parent)
  end
  
end
