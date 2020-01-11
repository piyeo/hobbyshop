class Admin::ItemsController < Admin::Base
  before_action :login_admin

  def index
    session.delete(:before_url)
    store_location
    @items = Item.page(params[:page]).per(20)
  end

  def show
    session.delete(:before_url)
    store_location
    @item = Item.find(params[:id])
    @reviews = @item.reviews.page(params[:page]).per(5)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "商品を登録しました。"
      redirect_to :admin_items
    else
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = "商品情報を変更しました。"
      redirect_to [:admin, @item]
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:category_id,:name, :body,:stock,:price,:release)
  end
end
