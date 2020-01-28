class CartsController < ApplicationController
  def show
    if params[:item_id] #カートからアイテム削除
      session[:cart_item].delete(params[:item_id])
    end
    if params[:number] #カートの商品の数量変更
      id = params[:id]
      begin
        if params[:number].to_i < 1 || params[:number].to_i > 99
          raise
        end
        session[:cart_item][id] = params[:number].to_i
      rescue
        flash.now[:danger] = "1〜99までの個数を指定してください。"
      end
    end
    if session[:cart_item] == {}
      flash.now[:warning] = "カートに商品が追加されていません。"
    end
  end

  def add
      if session[:cart_item].key?(params[:item_id])
        session[:cart_item][params[:item_id]] += params[:numbers].to_i
      else
        session[:cart_item][params[:item_id]] = params[:numbers].to_i
      end
      flash[:success] = "カートに商品を追加しました。"
      redirect_back_or root_url
  end
end
