class ParentsController < ApplicationController
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
  
  private
  def parent_params
    params.require(:parent).permit(:name, :email, :password, :password_confirmation)
  end
end
