class NumbersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_pincode, only: [:edit, :update]

  def new
    @number = Number.new
  end

  def create
    @number = Number.new(number_params)
    if @number.save!
      redirect_to numbers_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @number.update(number_params)
    redirect_to number_path
  end

  def index
    @numbers = Number.all
  end

  private

  def number_params
    params.require(:number).permit(:num, :primary, :user_id, :company_id)
  end

  def set_number
    @number = Number.find(params[:id])
  end
end
