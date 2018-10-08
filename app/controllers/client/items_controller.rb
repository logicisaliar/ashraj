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
    if @item.save!
      redirect_to client_order_items_path(params[:order_id])
    else
      render :new
      # calculate amount and quanity
    end
  end

  def index
    @items = Item.all
  end

  private

  def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Item.new
      t.name = row['name']
      t.save
    end
  end

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
