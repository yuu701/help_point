class ChildrenController < ApplicationController
  def new
    @child = Child.new
  end
  
  def create
    @child = Child.new(child_params)
    @child.parent_id = current_parent.id
    if @child.save
      redirect_to children_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def index
    @children = Child.all
  end
  
  private
  def child_params
    params.require(:child).permit(:name, :login_id, :password, :password_confirmation, :icon)
  end
end
