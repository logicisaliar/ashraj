class AddressesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def new
    @address = Address.new
    @pincodes = class_label(Pincode.all.sort_by &:pin)
  end

  def create
    @address = Address.new(address_params)
    @address.street = grammify(@address.street)[-1]
    @address.company = Company.find(params[:company])
    if @address.company.addresses.nil?
      @address.kind = 1
    else
      @address.kind = 2
    end
    if @address.save!
      redirect_to company_path(@address.company.id)
    else
      render :new
    end
  end

  def edit
    @pincodes = class_label(Pincode.all.sort_by &:pin)
    # @companies = Company.all.sort_by &:name
  end

  def update
    if @address.update(address_params)
      @address[:street] = grammify(@address[:street])[-1]
      @address.save
      redirect_to company_path(@address.company.id)
    else
      render :edit
    end
  end

  def index
    @addresses = Address.all
  end

  def show
  end

  private

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, p.pin]
    end
    return_array
  end

  def address_params
    params.require(:address).permit(:kind, :street, :pincode_id, :company_id)
  end

  def set_address
    @address = Address.find(params[:id])
  end

end
