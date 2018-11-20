class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def show
  end

  def edit
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  def update
    @item.update(item_params)
    @item = calculate_item(@item)
    @item.save
    redirect_to client_order_items_path(params[:order_id])
  end

  def destroy
    @item.destroy
    redirect_to client_order_items_path(params[:order])
  end

  private

  def item_params
    params.require(:item).permit(:product_id, :packing_id, :quantity, :discount)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
