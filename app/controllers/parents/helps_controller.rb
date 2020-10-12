class Parents::HelpsController < ApplicationController
  def new
    @help = Help.new
    @children = current_parent.children
  end
  
  def create
    @help = Help.new(help_params)
    @children = current_parent.children
    @help.parent_id = current_parent.id
    if @help.save
      redirect_to parents_helps_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @help = Help.find(params[:id])
    @children = current_parent.children
  end
  
  def update
    @help = Help.find(params[:id])
    @children = current_parent.children
    if @help.update_attributes(help_params)
      redirect_to parents_helps_path, success: "お手伝いを変更しました"
    else
      flash.now[:danger] = "お手伝いの変更に失敗しました"
      render :edit
    end
  end

  def index
    @children = current_parent.children
  end
  
  def destroy
    Help.find_by(id: params[:id]).destroy
    redirect_to parents_helps_path, success: 'お手伝いを削除しました'
  end
  
  private
  def help_params
    params.require(:help).permit(:name, :description, :point, :child_id)
  end
end
