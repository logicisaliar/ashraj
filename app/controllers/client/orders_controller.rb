class Client::OrdersController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  STATUS = ["pending", "completed", "confirmed", "packed", "invoiced", "dispatched", "released"]
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    unless params[:company].nil?
      @order.company = Company.find(params[:company])
    end
    if @order.company.addresses.length == 1
      @order.address = @order.company.addresses[0]
    else
      @addresses = address_label(Address.where(company: @order.company).all)
    end
    if @order.save
      redirect_to new_line_path(@order)
    else
      render :new
    end
  end

  def index
    @orders = Order.all
  end

  def show
    @lines = Line.where(order_id: @order.id).all
    status_up = params[:status_up]
    status_down = params[:status_down]
    unless status_down.nil?
      @order.status = STATUS[STATUS.index(status_down) - 1]
    end
    unless status_up.nil?
      @order.status = STATUS[STATUS.index(status_up) + 1]
    end
  end

  def edit
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  def update
    raise
    if @order.update(order_params)
      redirect_to client_order_path(@order)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to client_orders_path
  end

  def get_address
    render '/client/order/get_address'
  end

  private

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.name]
    end
    return_array
  end

  def address_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.street]
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

  def order_params
    params.require(:order).permit(:company_id, :item_id, :transport_id, :remark, :user_id, :other_taxes, :misc_charges, :address_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
