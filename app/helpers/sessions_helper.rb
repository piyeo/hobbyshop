module SessionsHelper

  def current_admin
    if session[:admin_id]
      @current_admin = @current_admin || Admin.find_by(id: session[:admin_id])
    end
  end

  def is_admin?
    !current_admin.nil?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
  if session[:user_id]
    @current_user = @current_user || User.find_by(id: session[:user_id])
  end
  end

  def is_login?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

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
