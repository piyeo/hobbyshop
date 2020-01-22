class UsersController < ApplicationController
  before_action :not_login_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ホビーショップNSに登録してくれてありがとう！"
      redirect_to :account
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :sex, :phone, :email, :birthday,
      :postcode, :address, :password, :password_confirmation)
  end

end
