class Parents::RequestsController < ApplicationController
  before_action :logged_in_parent
  before_action :correct_parent_for_requests, only:[:edit, :update, :destroy]
  
  def new
    @request = Request.new
    @help = Help.find_by(id: params[:help_id])
    @children = current_parent.children
  end
  
  def create
    @children = current_parent.children
    @help = Help.find_by(id: params[:request][:help_id])
    child_ids = params[:request][:child_id]
    Request.transaction do
      if child_ids
        child_ids.each do |child_id|
          @request = Request.new(request_params)
          @request.parent_id = current_parent.id
          @request.child_id = child_id
          @request.save!
        end
      else
        @request = Request.new(request_params)
        @request.parent_id = current_parent.id
        @request.save!
      end
      redirect_to parents_requests_path, success: "登録が完了しました"
    rescue => e
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    # @request = Request.find(params[:id])
    @children = current_parent.children
  end
  
  def update
    # @request = Request.find(params[:id])
    @children = current_parent.children
    if @request.update_attributes(request_params)
      redirect_to parents_requests_path, success: "お手伝いを変更しました"
    else
      flash.now[:danger] = "お手伝いの変更に失敗しました"
      render :edit
    end
  end

  def index
    @requests = current_parent.requests.where(status: false).includes(:child)
    @children = []
    @requests.each do |request|
      if @children.exclude?(request.child)
        @children.push(request.child)
      end
    end
  end
  
  def destroy
    Request.find_by(id: params[:id]).destroy
    redirect_to parents_requests_path, success: 'お手伝い依頼を削除しました'
  end
  
   private
  def request_params
    params.require(:request).permit(:name, :description, :point, :child_id, :request_date)
  end
  
  # requestに対して正しいparentかどうか確認
  def correct_parent_for_requests
    @request = Request.find_by(id: params[:id])
    redirect_to(parents_requests_path) unless correct_parent_for_model?(@request)
  end
end
