class Client::OrdersController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save!
      redirect_to orders_path
    else
      render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to client_orders_path
  end


  private

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.hsn]
    end
    return_array
  end

  def order_params
    params.require(:order).permit(:company_id, :item_id, :transport_id, :remark, :user_id, :other_taxes, :misc_charges)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
