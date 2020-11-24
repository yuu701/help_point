class IconsController < ApplicationController
  before_action :basic_auth, if: :production?
  
  def new
    @icon = Icon.new
  end
  
  def create
    @icon = Icon.new(icon_params)
    if @icon.save
      redirect_to icons_path, success: "登録が完了しました"
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
  
  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
