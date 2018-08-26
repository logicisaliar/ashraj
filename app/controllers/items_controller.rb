require 'csv'
class ItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to items_path
    else
      render :new
      # calculate amount and quanity
    end
  end

  def index
    @items = Item.all
  end

  def show
  end

  def edit
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  def update
    @item.update(item_params)
    redirect_to items_path
  end

  def destroy
    @item.destroy
    redirect_to items_path
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

  def set_item
    @item = Item.find(params[:id])
  end

end
