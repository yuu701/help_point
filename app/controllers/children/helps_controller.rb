class Children::HelpsController < ApplicationController
  def index
    @helps = current_child.helps
  end
end
