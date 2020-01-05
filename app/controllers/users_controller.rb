class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ホビーショップNSに登録してくれてありがとう！"
      redirect_to @user
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
