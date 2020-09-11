class HelpsController < ApplicationController
  def new
    @help = Help.new
    @children = Child.all
  end
  
  def create
    @help = Help.new(help_params)
    @children = Child.all
    @help.parent_id = current_parent.id
    # @help.child_id = params[:child_id]
    if @help.save
      redirect_to helps_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def index
    @helps = Help.all
  end
  
  private
  def help_params
    params.require(:help).permit(:name, :description, :point)
  end
end
