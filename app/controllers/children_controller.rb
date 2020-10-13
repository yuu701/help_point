class ChildrenController < ApplicationController
  def new
    @child = Child.new
    @icons = Icon.all
  end
  
  def create
    @child = Child.new(child_params)
    @icons = Icon.all
    @child.parent_id = current_parent.id
    if @child.save
      redirect_to children_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @child = Child.find(params[:id])
    @icons = Icon.all
  end
  
  def update
    @child = Child.find(params[:id])
    @icons = Icon.all
    if @child.update_attributes(child_params)
      redirect_to children_path, success: "お子さま情報を変更しました"
    else
      flash.now[:danger] = "お子さま情報の変更に失敗しました"
      render :edit
    end
  end

  def index
    @children = current_parent.children
  end
  
  def destroy
    Child.find_by(id: params[:id]).destroy
    redirect_to children_path, success: 'お子さまの名前を削除しました'
  end
  
  private
  def child_params
    params.require(:child).permit(:name, :login_id, :password, :password_confirmation, :icon)
  end
end
