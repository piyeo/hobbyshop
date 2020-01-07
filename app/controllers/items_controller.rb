class ItemsController < ApplicationController

  def index
    store_location
    @items = Item.page(params[:page]).per(20)
  end
  def show
    store_location
    @item = Item.find(params[:id])
  end
end
