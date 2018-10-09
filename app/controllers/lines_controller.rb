class LinesController < ApplicationController

  before_action :set_line, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def new
    @line = Line.new
    @line.order_id = params[:format]
    @products = class_label(Product.all)
    @packings = packing_label(Packing.all)
  end

  def create
    @item = Item.new(line_params)
    # @line = Line.new(line_params)
    if @item.save!
      redirect_to lines_path(params[:order_id])
    else
      render :new
      # calculate amount and quanity
    end
    @line = Line.new
    @line.item = @item
    @line.order_id = params[:order_id]
    @line.save!
  end

  def edit
  end

  def index
    @lines = Line.where(order_id: params[:format])
  end

  private

  def set_line
    @line = Line.find(params[:id])
  end

  def line_params
    params.require(:item).permit(:product_id, :packing_id, :quantity, :discount)
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

end
