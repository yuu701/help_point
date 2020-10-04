class Parents::RequestsController < ApplicationController
  def new
    @request = Request.new
    @help = Help.find_by(id: params[:help_id])
    @children = current_parent.children
    # binding.pry
  end
  
  def create
    @request = Request.new(request_params)
    @help = Help.find_by(id: params[:request][:help_id])
    @children = current_parent.children
    @request.parent_id = current_parent.id
    # binding.pry
    if @request.save
      redirect_to parents_requests_path, success: "登録が完了しました"
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @request = Request.find(params[:id])
    @help = Help.find_by(id: params[:request][:help_id])
    @children = current_parent.children
  end
  
  def update
    @request = Request.find(params[:id])
    @help = Help.find_by(id: params[:request][:help_id])
    @children = current_parent.children
    if @request.update_attributes(request_params)
      redirect_to requests_path, success: "お手伝いを変更しました"
    else
      flash.now[:danger] = "お手伝いの変更に失敗しました"
      render :edit
    end
  end

  def index
    @children = current_parent.children
  end
  
  def destroy
    Request.find_by(id: params[:id]).destroy
    redirect_to parents_requests_path, success: 'お手伝い依頼を削除しました'
  end
  
   private
  def request_params
    params.require(:request).permit(:name, :description, :point, :child_id, :request_date)
  end
end
