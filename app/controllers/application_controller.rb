class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Parents::SessionsHelper
  include Children::SessionsHelper
  
  add_flash_types :success, :info, :warning, :dander
  
  #beforeアクション
  # ログイン済parentかどうか確認
  def logged_in_parent
    unless parent_logged_in?
      flash[:danger] = "親アカウントのログインが必要です"
      if child_logged_in?
        redirect_to results_path
      else
        redirect_to parents_login_path
      end
    end
  end
  
  # ログイン済parentまたはchildの場合ログインページを表示しない
  def logged_out_parent_and_child
    if parent_logged_in? || child_logged_in?
      redirect_to results_path
    end
  end
  
end
