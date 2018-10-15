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
    if @item.save!
      redirect_to client_order_items_path(params[:order_id])
    else
      render :new
      # calculate amount and quanity
    end
  end

  def index
    @items = Item.where(order_id: params[:format])
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  private

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.name]
    end
    return_array
  end

  def packing_label(cls)
    return_array = []
    cls.each do |p|
      if p.sample
        a = "#{p.pack_size} (Sample)"
      else a = p.pack_size
      end
      return_array << [p.id, a]
    end
    return_array
  end

  def item_params
    params.require(:item).permit(:product_id, :packing_id, :quantity, :discount)
  end
end
