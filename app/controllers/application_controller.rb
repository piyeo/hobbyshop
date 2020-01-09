class ApplicationController < ActionController::Base
  before_action :current_cart

  include SessionsHelper

  def login_admin
    unless is_admin?
      flash[:danger] = "このページにアクセスするには管理者の権限が必要です。"
      redirect_to root_url
    end
  end

  def login_user
    unless is_login?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

    def not_login_user
      unless !is_login?
        redirect_to root_url
      end
    end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end
