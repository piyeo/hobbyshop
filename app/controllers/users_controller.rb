class UsersController < ApplicationController
  before_action :login_user, only: [:edit, :update,:destroy]
  before_action :not_login_user, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to :account
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "退会しました。"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :sex, :phone, :email, :birthday,
      :postcode, :address, :password, :password_confirmation)
  end

end
