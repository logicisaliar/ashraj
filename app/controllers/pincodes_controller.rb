class PincodesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_pincode, only: [:edit, :update]

  def new
    @pincode = Pincode.new
  end

  def create
    @pincode = Pincode.new(pincode_params)
    if @pincode.save!
      redirect_to new_address_path(company: params[:company])
    else
      render :new
    end
  end

  def edit
  end

  def update
    @pincode.update(pincode_params)
    redirect_to pincode_path
  end

  def index
    @pincodes = Pincode.all
  end

  private

  def pincode_params
    params.require(:pincode).permit(:pin, :city_id)
  end

  def set_pincode
    @pincode = Pincode.find(params[:id])
  end

  # def class_label(cls)
  #   return_array = []
  #   sorted = cls.sort_by &:name
  #   sorted.each do |p|
  #     return_array << [p.id, "#{p.name} (#{p.code}) "]
  #   end
  #   return_array
  # end


end

