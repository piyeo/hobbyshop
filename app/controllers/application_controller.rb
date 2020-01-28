class ApplicationController < ActionController::Base
  before_action :generate_cart

  include SessionsHelper
  include ItemsHelper

  if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end

  private def rescue_bad_request(exception)
    render "errors/bad_request", status: 400, layout: "error",
      formats: [:html]
  end

  private def rescue_not_found(exception)
    render "errors/not_found", status: 404, layout: "error",
      formats: [:html]
  end

  private def rescue_internal_server_error(exception)
    render "errors/internal_server_error", status: 500, layout: "error",
      formats: [:html]
  end

#管理者以外がログインしてきたらトップページへリダイレクト
  def login_admin
    unless is_admin?
      flash[:danger] = "このページにアクセスするには管理者の権限が必要です。"
      redirect_to root_url
    end
  end

#ゲストがログインしてきたらログイン画面へ誘導する
  def login_user
    unless is_login?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

#ユーザがログインしていたら不都合な場合、トップページに移動させログアウトを勧める
    def not_login_user
      unless !is_login?
        flash[:danger] = "ログアウトしてからやり直してください"
        redirect_to root_url
      end
    end

#管理者がログインしてたら不都合な場合、トップページに移動させログアウトを勧める
    def not_admin
      unless !is_admin?
        flash[:danger] = "ログアウトしてからやり直してください"
        redirect_to root_url
      end
    end

#現在ログインしているユーザの操作かをチェックする
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end
