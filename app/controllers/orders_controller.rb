class OrdersController < ApplicationController
  before_action :login_user

  def index
    @orders = current_user.orders.order("created_at DESC").page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
    if @order.user_id != current_user.id
      redirect_to root_url
    end
  end

  def new
    store_location
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    session[:cart_item].each do |item_id,numbers|
      if Item.find(item_id).stock < numbers
        flash[:danger] = "在庫より多い数は購入できません。"
        redirect_back_or :root and return
      end
    end
    if @order.save
      session[:cart_item].each do |item_id,numbers|
        item = Item.find(item_id)
        numbers.times{
          @order.items << item
          item.stock -= 1
          item.save
        }
      end
      session[:cart_item] = {}
      flash[:success] = "商品を購入しました。"
      redirect_to order_path(@order)
    else
      flash[:danger] = "購入に失敗しました。"
      redirect_to :root
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attribute(:isCancel ,params[:isCancel])
      flash[:success] = "注文をキャンセルしました。"
      @order.items.each do |i|
        item = Item.find(i.id)
        item.stock += 1
        item.save
      end
      redirect_to @order
    else
      redirect_to :orders
    end
  end

  private

    def order_params
      params.require(:order).permit(:pay,:totalprice)
    end

end
