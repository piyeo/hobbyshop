class ItemsController < ApplicationController
  before_action :admin_redirect

  def admin_redirect
    if is_admin?
      redirect_to :admin_root
    end
  end

  def index
    store_location
    @items = Item.page(params[:page]).per(20)
  end

  def show
    store_location
    @item = Item.find(params[:id])
    @reviews = @item.reviews.page(params[:page]).per(5)
    if is_login?
      if @item.reviews.find_by(user_id: current_user.id)
        #edit用
        @review = @item.reviews.find_by(user_id: current_user.id)
      else
        #new用
        @review = Review.new
      end
    end
  end

end
