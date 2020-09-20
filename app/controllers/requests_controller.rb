class RequestsController < ApplicationController
  def new
    @request = Request.new
    @help = Help.find_by(id: params[:help_id])
    @children = current_parent.children
  end
  
  def create
    @request = Request.new(request_params)
    @request.parent_id = current_parent.id
    if @request.save
      redirect_to helps_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def index
  end
  
   private
  def request_params
    params.require(:request).permit(:name, :description, :point, :child_id, :request_date)
  end
end
