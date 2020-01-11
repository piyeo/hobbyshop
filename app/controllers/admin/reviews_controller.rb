class Admin::ReviewsController < Admin::Base
  before_action :login_admin
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました。"
    redirect_back_or root_url
  end
end
