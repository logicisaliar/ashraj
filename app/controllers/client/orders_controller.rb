class Client::OrdersController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #             0           1             2         3           4           5             6
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
    @orders.each do |o|
      o.status = set_status(o).status
    end
  end

  def show
    @lines = Line.where(order_id: @order.id).all
    status_up = params[:status_up]
    status_down = params[:status_down]
    @order.status = set_status(@order).status
    unless status_down.nil?
      @order.status = STATUS[STATUS.index(status_down) - 1]
      if STATUS.index(@order.status) > 3
        @order.status = status_rollback(@order).status
      end
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
    @order.status = params[:status]
    if @order.update(order_params)
      @order.status = set_status(@order).status
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
    params.require(:order).permit(:company_id, :item_id, :transport_id, :remark, :user_id, :other_taxes, :misc_charges, :address_id, :status, :invoice_number, :invoiced_date, :lr, :freight, :dispatched_date, :released_date)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_status(o)
    if [o.invoiced_date, o.invoice_number].all?
      o.status = "invoiced"
      if [o.dispatched_date, o.lr].all?
        o.status = "dispatched"
        if [o.released_date].all?
          o.status = "released"
        end
      end
    end
    return o
  end

  def status_rollback(o)
    status = STATUS.index(@order.status)
    if status == 4
      o.invoiced_date = nil
      o.invoice_number = nil
    elsif status == 5
      o.dispatched_date = nil
      o.lr = nil
    elsif status == 6
      o.released_date = nil
    end
    return o
  end

end
