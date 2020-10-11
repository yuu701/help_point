class Parents::AppliesController < ApplicationController
  def index
    @children = current_parent.children
  end
  
  def destroy
    apply = Apply.find_by(id: params[:id])
    apply.destroy
    request = apply.request
    request.update_attributes(status: false)
    redirect_to parents_applies_path, success: '承認を却下しました'
  end
end
