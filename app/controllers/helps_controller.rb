class HelpsController < ApplicationController
  def new
    @help = Help.new
    @children = current_parent.children
  end
  
  def create
    @help = Help.new(help_params)
    @children = current_parent.children
    @help.parent_id = current_parent.id
    if @help.save
      redirect_to helps_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def index
    @helps = current_parent.helps
  end
  
  private
  def help_params
    params.require(:help).permit(:name, :description, :point, :child_id)
  end
end
