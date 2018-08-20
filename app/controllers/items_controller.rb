require 'csv'
class ItemsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def new
    @products = item_prod
    @item = Item.new
  end

  def index
  end

  def edit
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

  def item_prod
    prods = []
    count = 1
    Product.count.times do
      prods << [Product.find(count).id, Product.find(count).name]
      count += 1
    end
    prods
  end

  def item_pack
    packs = []
    count = 1
    Packing.count.times do
      packs << [Packing.find(count).id, Packing.find(count).pack_size]
      count += 1
    end
    packs
  end

  def item_params
    params.require(:item).permit(:product_id, :discount, :packing_id, :amount, :price)
  end

  def product_disc
    if params[:product_id]
      @discount = Product.find(params[:product_id]).discount
    end

    respond_with(@discount) do |format|
      format.json { render :json => @discount.to_json }
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
