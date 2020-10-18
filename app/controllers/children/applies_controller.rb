class Children::AppliesController < ApplicationController
  before_action :logged_in_child
  before_action :correct_child_for_applies, only:[:edit, :update, :destroy]
  
  def new
    @apply = Apply.new
    # リクエストからのお手伝い報告
    if params[:request_id] != nil
      @request = Request.find_by(id: params[:request_id])
      render "children/applies/from_request_new"
    # お手伝いリストからのお手伝い報告
    elsif params[:help_id] != nil
      @help = Help.find_by(id: params[:help_id])
      render "children/applies/direct_new"
    end
  end
  
  def create
    @apply = Apply.new(apply_params)
    # リクエストからのお手伝い報告
    if @request = Request.find_by(id: params[:apply][:request_id])
      @apply.request_id = params[:apply][:request_id]
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
        render :from_request_new
      end
     # お手伝いリストからのお手伝い報告
    elsif @help = Help.find_by(id: params[:apply][:help_id])
      @request = Request.new(
        name: @help.name, 
        description: @help.description, 
        point: @help.point, 
        parent_id: @help.parent_id, 
        child_id: @help.child_id,
        request_date: @apply.completion_date,
        status: true)
      begin
          Request.transaction do
            Apply.transaction do
              @request.save!
              @apply.request_id = @request.id
              @apply.save!
            end
        end
        redirect_to children_helps_path, success: "ママ・パパに報告しました"
      rescue => e
        flash.now[:danger] = "報告が失敗しましたた"
        render :direct_new
      end
    end
  end
  
  def edit
    # @apply = Apply.find(params[:id])
    @request = @apply.request
  end
  
  def update
    # @apply = Apply.find(params[:id])
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
  
  # applyに対して正しいchildかどうか確認
  def correct_child_for_applies
    @apply = Apply.find(params[:id])
    redirect_to(children_applies_path) unless correct_child_for_model?(@apply.request)
  end
end
