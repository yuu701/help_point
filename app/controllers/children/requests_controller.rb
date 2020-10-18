class Children::RequestsController < ApplicationController
  before_action :logged_in_child
  
  def index
    @requests = current_child.requests.where(status: false)
  end
end
