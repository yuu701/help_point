class ResultsController < ApplicationController
  def new
    # ポイント承認ページ
    @result = Result.new
    if params[:apply_id] != nil
      @apply = Apply.find_by(id: params[:apply_id])
      render "results/approval_new"
    # ポイント登録ページ
    elsif params[:help_id] != nil
      @help = Help.find_by(id: params[:help_id])
      render "results/direct_new"
    end
  end
  
  def create
    @result = Result.new(result_params)
    @result.parent_id = current_parent.id
    # ポイント承認処理
    if @apply = Apply.find_by(id: params[:result][:apply_id])
      @result.appeal_comment = @apply.comment
      @result.child_id = @apply.request.child_id
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
        render :approval_new
      end
    # ポイントを直接登録する処理
    elsif @help = Help.find_by(id: params[:result][:help_id])
      @result.child_id = @help.child_id
      @request = Request.new(
        name: @help.name, 
        description: @help.description, 
        point: @help.point, 
        parent_id: @help.parent_id, 
        child_id: @help.child_id,
        request_date: @result.completion_date,
        status: true)
      @apply = Apply.new(
        comment: nil,
        completion_date: @result.completion_date,
        close: true)
      begin
        Result.transaction do
          Request.transaction do
            Apply.transaction do
              @result.save!
              @request.save!
              @apply.request_id = @request.id
              @apply.save!
            end
          end
        end
        redirect_to parents_helps_path, success: "ポイント登録が完了しました"
      rescue => e
        flash.now[:danger] = "ポイント登録に失敗しました"
        render :direct_new
      end
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
    
    # @day = {}
    # @results.each do |result|
    #   result[:completion_date]  
    # end
    
    if params[:date] != nil
      @date = params[:date]
      render "results/result_day"
    else
      render "results/result_month"
    end
    # binding.pry
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
