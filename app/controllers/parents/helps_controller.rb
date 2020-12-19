class Parents::HelpsController < ApplicationController
  before_action :logged_in_parent
  before_action :correct_parent_for_helps, only:[:edit, :update, :destroy]
  
  def new
    # @help = Help.new
    @help = current_parent.helps.build
    @children = current_parent.children
  end
  
  def create
    @children = current_parent.children
    child_ids = params[:help][:child_id]
    # Help.transaction do
    #   if child_ids
    #     child_ids.each do |child_id|
    #       # @help = Help.new(help_params)
    #       # @help.parent_id = current_parent.id
    #       @help = current_parent.helps.build(help_params)
    #       @help.child_id = child_id
    #       @help.save!
    #     end
    #   else
    #     # @help = Help.new(help_params)
    #     # @help.parent_id = current_parent.id
    #     @help = current_parent.helps.build(help_params)
    #     @help.save!
    #   end
    #   redirect_to parents_helps_path, success: "登録が完了しました"
    # rescue => e
    #   flash.now[:danger] = "登録に失敗しました"
    #   render :new
    # end
    
    helps_data = []
    if child_ids
      child_ids.each do |child_id|
        @help = current_parent.helps.build(help_params)
        @help.child_id = child_id
        if @help.invalid?
          flash.now[:danger] = "登録に失敗しました"
          render :new
          return
        else
          helps_data.push(@help)
        end
      end
      Help.import helps_data
      redirect_to parents_helps_path, success: "登録が完了しました"
    else
      @help = current_parent.helps.create(help_params)
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  def edit
    # @help = Help.find(params[:id])
    @children = current_parent.children
  end
  
  def update
    # @help = Help.find(params[:id])
    @children = current_parent.children
    if @help.update_attributes(help_params)
      redirect_to parents_helps_path, success: "お手伝いを変更しました"
    else
      flash.now[:danger] = "お手伝いの変更に失敗しました"
      render :edit
    end
  end

  def index
    @children = current_parent.children.includes(:helps)
  end
  
  def destroy
    Help.find_by(id: params[:id]).destroy
    redirect_to parents_helps_path, success: 'お手伝いを削除しました'
  end
  
  private
  def help_params
    params.require(:help).permit(:name, :description, :point, :child_id)
  end
  
  # helpに対して正しいparentかどうか確認
  def correct_parent_for_helps
    @help = Help.find_by(id: params[:id])
    redirect_to(parents_helps_path) unless correct_parent_for_model?(@help)
  end
end
