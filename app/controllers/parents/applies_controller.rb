class Parents::AppliesController < ApplicationController
  before_action :logged_in_parent
  before_action :correct_parent_for_applies, only:[:destroy]
  
  def index
    @applies = current_parent.applies.where(close: false)
    @children = current_parent.children
  end
  
  def destroy
    apply = Apply.find_by(id: params[:id])
    request = apply.request
    Apply.transaction do
      Request.transaction do
        apply.destroy!
        request.update_attributes(status: false)
      end
    end
    redirect_to parents_applies_path, success: '承認を却下しました'
  end
  
  # beforeアクション
  
  # applyに対して正しいparentかどうか確認
  def correct_parent_for_applies
    @apply = Apply.find(params[:id])
    redirect_to(parents_applies_path) unless correct_parent_for_model?(@apply.request)
  end
end
