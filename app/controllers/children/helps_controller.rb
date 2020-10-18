class Children::HelpsController < ApplicationController
  before_action :logged_in_child
  
  def index
    @helps = current_child.helps
  end
end
