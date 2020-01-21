class Admin::OrdersController < Admin::Base
  before_action :login_admin

  def index
    @orders = Order.all.order("created_at DESC").page(params[:page]).per(5)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attribute(:isDeliver ,params[:isDeliver])
      if @order.isDeliver
        flash[:success] = "商品を発送しました。"
      else
        flash[:success] = "商品の発送をキャンセルしました。"
      end
      redirect_to :admin_orders
    else
      redirect_to :admin_orders
    end
  end

end
