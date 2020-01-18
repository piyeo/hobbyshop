class Admin::ItemsController < Admin::Base
  before_action :login_admin

  def search
    store_location
    if params[:category_id] == "0"
      @items = Item.search(params[:q]).page(params[:page]).per(9)
    else
      @items = Item.search(params[:q]).where("category_id = #{params[:category_id]}").page(params[:page]).per(9)
    end
    @category_id = params[:category_id]  || Category.first.id
    render "index"
  end

  def index
    session.delete(:before_url)
    store_location
    @items = Item.order("name").page(params[:page]).per(9)
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
    params.require(:item).permit(:new_item_image,:remove_item_image,:category_id,:name, :body,:stock,:price,:release)
  end
end
