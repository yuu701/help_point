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
    @result.parent_id = current_parent.id
    @result.child_id = @apply.request.child_id
    # binding.pry
    # if @result.save
    #   @apply.update_attributes(close: true)
    #   redirect_to helps_path, success: "承認が完了しました"
    # else
    #   flash.now[:danger] = "承認に失敗しました"
    #   render :new
    # end
     begin
      Result.transaction do
        Apply.transaction do
          @result.save!
          @apply.update_attributes!(close: true)
        end
      end
      redirect_to parents_applies_path, success: "承認が完了しました"
    rescue => e
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

  def index
    if parent_logged_in?
      @children = current_parent.children
      @results = current_parent.results.order(child_id: "ASC")
    elsif child_logged_in?
      @children = current_child.parent.children
      @results = current_child.parent.results.order(child_id: "ASC")
    end
    
    if params[:date] != nil
      @date = params[:date]
      render "results/_result_day"
    else
      render "results/_result_month"
    end
  end
  
  def show
    # if parent_logged_in?
    #   @children = current_parent.children
    #   # @results = current_parent.results.where(completion_date: @date)
    # elsif child_logged_in?
    #   @children = current_child.parent.children
    #   # @results = current_child.parent.results.where(completion_date: @date)
    # end
  end
  
  # def destroy
  #   Request.find_by(id: params[:id]).destroy
  #   redirect_to requests_path, success: 'お手伝い依頼を削除しました'
  # end
  
   private
  def result_params
    params.require(:result).permit(:name, :description, :point, :bonus, :completion_date, :parents_comment)
  end
end
