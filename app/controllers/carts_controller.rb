class CartsController < ApplicationController
  def show
    if params[:item_id]
      session[:cart_item].delete(params[:item_id].to_i)
    end
    @items = session[:cart_item].map do |i|
      Item.find(i)
    end
    if session[:cart_item].count == 0
      flash.now[:warning] = "カートに商品が追加されていません。"
    end
  end
  def add
    session[:cart_item] = session[:cart_item].push(params[:item_id].to_i)
    redirect_back_or root_url
  end
end
