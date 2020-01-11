class AdminsController < ApplicationController
  before_action :not_login_user

  def new
  end

  def create
    admin = Admin.find_by(name: params[:admin][:name])
    if admin&.authenticate(params[:admin][:password])
      session[:admin_id] = admin.id
      redirect_to controller: 'admin/top', action: 'index'
    else
      flash.now[:danger] = 'ユーザー名、もしくはパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    session.delete(:admin_id)
    @current_admin = nil
    redirect_to :root
  end
end
