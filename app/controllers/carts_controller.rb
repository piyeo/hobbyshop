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
    cart_item_number = session[:cart_item].count(params[:item_id].to_i)
    if (Item.find(params[:item_id]).stock - cart_item_number) > params[:numbers].to_i
      params[:numbers].to_i.times do |i|
        session[:cart_item] = session[:cart_item].push(params[:item_id].to_i)
      end
      flash[:success] = "カートに商品を追加しました。"
    else
      flash[:danger] = "カートに商品を追加できませんでした。"
    end
    redirect_back_or root_url
  end
end
