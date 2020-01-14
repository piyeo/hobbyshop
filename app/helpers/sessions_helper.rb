module SessionsHelper

#初めてアクセスしたらカートを生成する
  def generate_cart
    if session[:cart_item].nil?
      @current_cart = Array.new
      session[:cart_item] = @current_cart
    end
  end

#現在ログインしてる管理者を返す
  def current_admin
    if session[:admin_id]
      @current_admin = @current_admin || Admin.find_by(id: session[:admin_id])
    end
  end

#管理者かどうかを確認
  def is_admin?
    !current_admin.nil?
  end

#ログインする
  def log_in(user)
    session[:user_id] = user.id
  end

#ログイン中のユーザを返す
  def current_user
    if session[:user_id]
      @current_user = @current_user || User.find_by(id: session[:user_id])
    end
  end

#ログインしてるかどうかを確認する
  def is_login?
    !current_user.nil?
  end

#ログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

#引数がログイン中のユーザーかどうかを判定
  def current_user?(user)
    user == current_user
  end

#記録したURLにリダイレクト(ない場合はデフォルト値を入れる)
  def redirect_back_or(default)
    redirect_to(session[:before_url] || default)
    session.delete(:before_url)
  end

#アクセスしようとしたURLを記憶する
  def store_location
    session[:before_url] = request.original_url if request.get?
  end
end
