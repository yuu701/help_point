class Parents::AppliesController < ApplicationController
  def index
    @children = current_parent.children
    @applies = current_child.applies.where(close: false)
  end
  
  def destroy
    apply = Apply.find_by(id: params[:id])
    apply.destroy
    request = apply.request
    request.update_attributes(status: false)
    redirect_to children_applies_path, success: '報告をやめました'
  end
end
