class AddressesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save!
      redirect_to addresses_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to host_address_path(@address)
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

  def address_params
    params.require(:address).permit(:type, :street, :pincode_id, :company_id)
  end

  def set_address
    @address = Address.find(params[:address_id])
  end

end
