class OrdersController < ApplicationController
  before_action :login_user

  def index
    @orders = current_user.orders.page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    if @order.user_id != current_user.id
      redirect_to root_url
    end
  end

  def new
    @items = session[:cart_item].map do |i|
      Item.find(i)
    end
    @order = Order.new
  end

  def create
    @order = Order.new(pay: params[:order][:pay],isDeliver: false,isCancel: false)
    @order.user = current_user
    if @order.save
      @items = session[:cart_item].map do |i|
        @order.items << Item.find(i)
        item = Item.find(i)
        item.stock -= 1
        item.save
      end
      session[:cart_item] = []
      flash[:success] = "商品を購入しました。"
      redirect_to order_path(@order)
    else
      flash[:danger] = "購入に失敗しました。"
      redirect_to :root
    end
  end

end
