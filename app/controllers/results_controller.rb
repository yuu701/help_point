class ResultsController < ApplicationController
  def new
    @result = Result.new
    @apply = Apply.find_by(id: params[:apply_id])
    # binding.pry
  end
  
  def create
    @result = Result.new(result_params)
    @apply = Apply.find_by(id: params[:result][:apply_id])
    @result.appeal_comment = @apply.comment
    @result.child_id = @apply.request.child_id
    # binding.pry
    if @result.save
      @apply.update_attributes(close: true)
      redirect_to helps_path, success: "承認が完了しました"
    else
      flash.now[:danger] = "承認に失敗しました"
      render :new
    end
  end
  
  # def edit
  #   @request = Request.find(params[:id])
  #   @help = Help.find_by(id: params[:request][:help_id])
  #   @children = current_parent.children
  # end
  
  # def update
  #   @request = Request.find(params[:id])
  #   @help = Help.find_by(id: params[:request][:help_id])
  #   @children = current_parent.children
  #   if @request.update_attributes(request_params)
  #     redirect_to requests_path, success: "お手伝いを変更しました"
  #   else
  #     flash.now[:danger] = "お手伝いの変更に失敗しました"
  #     render :edit
  #   end
  # end

  # def index
  #   if parent_logged_in?
  #     @children = current_parent.children
  #   elsif child_logged_in?
  #     @requests = current_child.requests.where(status: false)
  #   end
  # end
  
  # def destroy
  #   Request.find_by(id: params[:id]).destroy
  #   redirect_to requests_path, success: 'お手伝い依頼を削除しました'
  # end
  
   private
  def result_params
    params.require(:result).permit(:name, :description, :point, :bonus, :completion_date, :parents_comment)
  end
end
