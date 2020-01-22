class AccountsController < ApplicationController
  before_action :login_user, only: [:show,:edit ,:update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_name = current_user.name
    if @user.update_attributes(account_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to :account
    else
      current_user.name = user_name
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = "退会しました。"
    redirect_to root_url
  end

  private

  def account_params
    params.require(:user).permit(:name, :nickname, :sex, :phone, :email, :birthday,
      :postcode, :address, :password, :password_confirmation)
  end
end
