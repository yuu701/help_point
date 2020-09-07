class ParentsController < ApplicationController
  
  def show
  end
  
  def new
    @parent = Parent.new
  end
  
  def create
    @parent = Parent.new(parent_params)
    if @parent.save
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
    @parent = Parent.find_by(params[:id])
    if current_parent == @parent
      redirect_to root_path, success: "アカウント情報を変更しました"
    else
      flash.now[:danger] = "アカウント情報の変更に失敗しました"
      render :edit
    end
  end
  
  private
  def parent_params
    params.require(:parent).permit(:name, :email, :password, :password_confirmation)
  end
end
