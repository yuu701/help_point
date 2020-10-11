class Children::AppliesController < ApplicationController
  def new
    @apply = Apply.new
    @request = Request.find_by(id: params[:request_id])
  end
  
  def create
    @apply = Apply.new(apply_params)
    @apply.request_id = params[:apply][:request_id]
    @request = Request.find_by(id: params[:apply][:request_id])
    begin
      Apply.transaction do
        Request.transaction do
          @apply.save!
          @request.update_attributes!(status: true)
        end
      end
      redirect_to children_requests_path, success: "ママ・パパに報告しました"
    rescue => e
      flash.now[:danger] = "報告が失敗しました"
      render :new
    end
  end
  
  def edit
    @apply = Apply.find(params[:id])
    @request = @apply.request
  end
  
  def update
    @apply = Apply.find(params[:id])
    @request = @apply.request
    if @apply.update_attributes(apply_params)
      redirect_to children_applies_path, success: "お手伝い報告を変更しました"
    else
      flash.now[:danger] = "お手伝い報告の変更に失敗しました"
      render :edit
    end
  end

  def index
    @applies = current_child.applies.where(close: false)
  end
  
  def destroy
    apply = Apply.find_by(id: params[:id])
    request = apply.request
    Apply.transaction do
      Request.transaction do
        apply.destroy!
        request.update_attributes!(status: false)
      end
    end
    redirect_to children_applies_path, success: '報告をやめました'
  end
  
   private
  def apply_params
    params.require(:apply).permit(:comment, :completion_date)
  end
end
