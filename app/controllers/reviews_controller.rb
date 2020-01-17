class ReviewsController < ApplicationController
  before_action :login_user, except: [:index]

  def index
    store_location
    @reviews = current_user.reviews.order("created_at DESC").page(params[:page]).per(10)
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.item = Item.find(params[:item_id])
    if @review.save
      flash[:success] = "レビューを投稿しました。"
      redirect_back_or root_url
    else
      @review.errors.full_messages.each do |e|
        flash[:danger] = flash[:danger].to_s + e + "<br>"
      end
      redirect_back_or root_url
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "レビューを編集しました。"
      redirect_back_or root_url
    else
      @review.errors.full_messages.each do |e|
        flash[:danger] = flash[:danger].to_s + e + "<br>"
      end
      redirect_back_or root_url
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました。"
    redirect_back_or root_url
  end

private

  def review_params
    params.require(:review).permit(:score,:body)
  end

end
