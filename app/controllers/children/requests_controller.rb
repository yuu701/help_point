class Children::RequestsController < ApplicationController
  def index
    @requests = current_child.requests.where(status: false)
  end
end
