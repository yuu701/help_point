class AppliesController < ApplicationController
  def new
    @apply = Apply.new
    @request = Request.find_by(id: params[:request_id])
  end
  
  def create
    @apply = Apply.new(apply_params)
    @apply.request_id = params[:apply][:request_id]
    @request = Request.find_by(id: params[:apply][:request_id])
    # debugger
    # binding.pry
    if @apply.save
      @request.update_attributes(status: true)
      redirect_to children_requests_path, success: "ママ・パパに報告しました"
    else
      flash.now[:danger] = "報告が失敗しました"
      render :new
    end
  end

  def index
  end
  
   private
  def apply_params
    params.require(:apply).permit(:comment, :completion_date)
  end
end
