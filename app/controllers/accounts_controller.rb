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
    if @user.update_attributes(account_params)
      flash[:success] = "アカウント情報を変更しました。"
      redirect_to :account
    else
      render 'edit'
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :nickname, :sex, :phone, :email, :birthday,
      :postcode, :address, :password, :password_confirmation)
  end
end
