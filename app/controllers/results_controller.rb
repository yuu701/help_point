class ResultsController < ApplicationController
  before_action :logged_in_parent_or_child
  before_action :correct_parent_for_results, only:[:edit, :update, :destroy]
  
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
      @result.apply_id = @apply.id
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
        comment: "",
        completion_date: @result.completion_date,
        close: true)
      begin
        Request.transaction do
          Apply.transaction do
            Result.transaction do
              @request.save!
              @apply.request_id = @request.id
              @apply.save!
              @result.appeal_comment = @apply.comment
              @result.apply_id = @apply.id
              @result.save!
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
  
  def edit
    @result = Result.find(params[:id])
  end
  
  def update
    @result = Result.find(params[:id])
    if @result.update_attributes(result_params)
      redirect_to results_path, success: "ポイントを変更しました"
    else
      flash.now[:danger] = "ポイントの変更に失敗しました"
      render :edit
    end
  end

  def index
    if parent_logged_in?
      @children = current_parent.children.includes(:icon)
      @applies = current_parent.applies.where(close: false)
      @results = current_parent.results.order(child_id: "ASC").includes(:child)
      parent = current_parent
    elsif child_logged_in?
      @children = current_child.parent.children.includes(:icon)
      @requests = current_child.requests.where(status: false)
      @results = current_child.parent.results.order(child_id: "ASC").includes(:child)
      parent = current_child.parent
    end
    
    @displays = {}
    @results.each do |result|
      if @displays.key?(result.completion_date)
        if @displays[result.completion_date].exclude?(result.child)
          @displays[result.completion_date].push(result.child)
        end
      else
        @displays[result.completion_date] = [result.child]
      end
    end

    @display_children = []
    @displays.each do |k,v|
      struct = Struct.new("Display",:start_time, :child) 
      @display_children.push(struct.new(k, v))
    end
    
    if params[:start_date]
      @search_date = params[:start_date]
    else
      @search_date = Date.today
    end
    @search_month = @search_date.to_date
    
    month_beginning = @search_month.beginning_of_month.strftime("%Y-%m-%d")
    month_end = @search_month.end_of_month.strftime("%Y-%m-%d")
    query = <<~QUERY
      SELECT SUM(results.point + results.bonus) AS "total_point", child_id 
      FROM results 
      WHERE parent_id = #{parent.id} AND results.completion_date
      BETWEEN '#{month_beginning}' AND '#{month_end}'
      GROUP BY child_id 
    QUERY
    points_data = ActiveRecord::Base.connection.select_all(query)
    points = points_data.to_a
    point_data_hash = {}
    points.each do |point|
      point_data_hash[point["child_id"]] = point["total_point"]
    end
    @children.each do |child|
      if point_data_hash.has_key?(child.id)
        child.total_point = point_data_hash[child.id]
      else
        child.total_point = 0
      end
    end
    
    
    if params[:date]
      @date = params[:date]
      render "results/result_day"
    else
      render "results/result_month"
    end
  end
  
  # def show
    # if parent_logged_in?
    #   @children = current_parent.children
    #   # @results = current_parent.results.where(completion_date: @date)
    # elsif child_logged_in?
    #   @children = current_child.parent.children
    #   # @results = current_child.parent.results.where(completion_date: @date)
    # end
  # end
  
  def destroy
    result = Result.find(params[:id])
    request = result.apply.request
    apply = result.apply
    Request.transaction do
      Apply.transaction do
        Result.transaction do
          request.destroy!
          apply.destroy!
          result.destroy!
        end
      end
    end
    redirect_to root_path, success: 'お手伝い実績を削除しました'
  end
  
   private
  def result_params
    params.require(:result).permit(:name, :description, :point, :bonus, :completion_date, :parents_comment)
  end
  
  #beforeアクション
  # ログイン済parentまたはchildどうか確認
  def logged_in_parent_or_child
    unless parent_logged_in? || child_logged_in?
      flash[:danger] = "ログインが必要です"
        redirect_to root_path
    end
  end
  
  # requestに対して正しいparentかどうか確認
  def correct_parent_for_results
    @result = Result.find_by(id: params[:id])
    redirect_to(results_path) unless correct_parent_for_model?(@result)
  end
  
end
