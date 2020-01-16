class Admin::ReviewsController < Admin::Base
  before_action :login_admin

  def index
    store_location
    @reviews = Review.all.order("created_at DESC").page(params[:page]).per(10)
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました。"
    redirect_back_or root_url
  end
end
