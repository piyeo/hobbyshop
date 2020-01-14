class ApplicationController < ActionController::Base
  before_action :generate_cart

  include SessionsHelper

#options_for_select　カテゴリー用
  def category_choices
    categories = {}
    Category.all.each do |category|
      categories.merge!(category.name => category.id)
    end
    categories
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
