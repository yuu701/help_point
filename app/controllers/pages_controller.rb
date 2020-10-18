class PagesController < ApplicationController
  before_action :logged_out_parent_and_child
  def index
  end
end
