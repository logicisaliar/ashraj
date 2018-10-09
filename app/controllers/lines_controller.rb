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
    @line = Line.new(line_params)
    raise
    if @line.save
      redirect_to lines_path(@line)
    else
      render :new
    end
  end

  def edit
  end

  def index
    raise
    @lines = Line.all
  end

  private

  def set_line
    @line = Line.find(params[:id])
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
