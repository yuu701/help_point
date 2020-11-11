class IconsController < ApplicationController
  def new
    @icon = Icon.new
  end
  
  def create
    @icon = Icon.new(icon_params)
    if @icon.save
      redirect_to root_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def index
    @icons = Icon.all
  end
  
  private
  def icon_params
    params.require(:icon).permit(:image)
  end
  
end
