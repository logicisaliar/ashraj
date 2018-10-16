
class Client::ItemsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
    @order = Order.find(params[:order_id])
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.order_id = params[:order_id]
    @item.discount = calculate_discount(@item)
    @item = calculate_item(@item)
    if @item.save
      @order = Order.find(@item.order_id)
      @order = calculations(@order)
      @order.save
      redirect_to client_order_items_path(params[:order_id])
    else
      @products = class_label(Product.all)
      @packings = packing_label(Packing.all)
      render :new
    end
  end

  def index
    @items = Item.where(order_id: params[:format])
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  private

  def item_params
    params.require(:item).permit(:product_id, :packing_id, :quantity, :discount)
  end

  def calculate_discount(i)
    if i.order.company.kind == 2
      return i.product.discount
    else
      #Provide option to edit with default value being as per last.
      return 15.254
    end
  end


end
