class Client::OrdersController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def new
    @order = Order.new
    # @companies = company_order(Company.all.sort_by &:name)
    @companies = Company.all.sort_by &:name
  end

  def create
    @order = Order.new(order_params)
    @transports = transport_array(@order)
    if params[:company].nil?
      @order.company = Company.find(Company.where(id: order_params[:company_id]).ids[0])
    else
      @order.company = Company.find(params[:company])
    end
    unless params[:transport].nil?
      @order.transport = Transport.find(params[:transport])
    end
    @addresses = address_label(Address.where(company: @order.company))
    if @order.save
      redirect_to new_client_order_item_path(@order, company: @order.company)
    else
      render :new
    end
  end

  def index
    @orders = Order.all
    @orders.each do |o|
      o = set_status(o)
    end
  end

  def show
    @items = Item.where(order_id: @order.id).all
    status_up = params[:status_up]
    status_down = params[:status_down]
    @order = set_status(@order)
    @number = truncate_num(Number.where(company: @order.company).to_a, 30)
    @email = truncate_mail(Email.where(company: @order.company).to_a, 30)
    status = STATUS.index(@order.status) + 1
    unless status_down.nil?
      @order.status = STATUS[STATUS.index(status_down) - 1]
      @order = status_rollback(@order)
    end
    unless status_up.nil?
      if status == 2
        @order.confirmed_date = Date.today
      elsif status == 3
        @order.packed_date = Date.today
      end
      @order.status = STATUS[status]
    end
    @order = calculations(@order)
    @order.save!
  end

  def edit
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  def update
    @order.status = params[:status]
    if @order.update(order_params)
      @order = set_status(@order)
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


  def address_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.street]
    end
    return_array
  end

  def order_params
    params.require(:order).permit(:company_id, :item_id, :transport_id, :remark, :user_id, :other_taxes, :misc_charges, :address_id, :status, :invoice_number, :invoiced_date, :lr, :freight, :dispatched_date, :released_date, :salesperson)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_status(o)
    if [o.salesperson].all?
      o.status = "completed"
      if [o.confirmed_date].all?
        o.status = "confirmed"
        if [o.packed_date].all?
          o.status = "packed"
          if [o.invoiced_date, o.invoice_number].all?
            o.status = "invoiced"
            if o.company.kind == 3
              if o.brokerage.nil?
                b = Brokerage.new
                b.order = o
              else
                b = Brokerage.find_by(order_id: o.id)
              end
              b.brokerage_date = o.invoiced_date
              b = calculate_brokerage(b)
            end
            if [o.dispatched_date, o.lr].all?
              o.status = "dispatched"
              if [o.released_date].all?
                o.status = "released"
              end
            end
          end
        end
      end
    end
    o.completed_date = Date.today
    return o
  end

  def status_rollback(o)
    status = STATUS.index(@order.status) + 1
    if status == 1
      o.completed_date = nil
      o.salesperson = nil
    elsif status == 2
      o.confirmed_date = nil
    elsif status == 3
      o.packed_date = nil
    elsif status == 4
      o.invoiced_date = nil
      o.invoice_number = nil
    elsif status == 5
      o.dispatched_date = nil
      o.lr = nil
      o.freight = nil
    elsif status == 6
      o.released_date = nil
    end
    return o
  end



  def transport_array(o)
    #Filter Tranport list depending on previous orders of the company and if 0, only courier companies
    return Transport.all
  end

  def company_order(companies)
    final_array = []
    State.all.each do |s|
      a = []
      a << s.name
      comp_array = []
      companies.each do |c|
        unless (c.kind == 0 || c.addresses.length == 0)
          if c.addresses.where(kind: 1)[0].pincode.city.state.name == s.name
            comp_array << c.name
          end
        end
      end
      a << comp_array
      final_array << a
    end
    final_array
  end

  def calculate_brokerage(b)
    amount = 0
    b.order.items.each do |i|
      amount += ((i.product.discount - i.discount) * i.total * i.mrp) / 100
    end
    b.amount = amount
    b.brokerage_date = b.order.invoiced_date
    b.company_id = b.order.company.parent.id
    b.save
    b = calculate_tds(b)
    b
  end

  def calculate_tds(b)
    brokerages = Brokerage.where(company_id: b.company.id)
    amount = 0
    brokerages.each do |brokerage|
      amount += brokerage.amount if current_financial_year?(brokerage.brokerage_date)
    end
    b.company.pan_number.nil? ? tds_per = 0.2 : tds_per = 0.05
    if amount > 15000 && amount - brokerages[-1].amount <= 15000
      b.tds = amount * tds_per
      b.narration = "First TDS"
    elsif amount > 15000
      b.tds = b.amount * tds_per
      b.narration = "TDS, not first"
    else
      b.tds = 0
      b.narration = "Blah"
    end
    b.commission = b.amount - b.tds
  end

end

