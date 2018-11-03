class NumbersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_number, only: [:edit, :update]

  def new
    @number = Number.new
  end

  def create
    @number = Number.new(number_params)
    @number.company = Company.find(params[:company])
    @number = number_type(@number)
    if @number.save
      redirect_to company_path(@number.company.id)
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
    @numbers = Company.find(params[:company]).numbers
  end

  private

  def number_params
    params.require(:number).permit(:num, :primary, :user_id, :company_id)
  end

  def set_number
    @number = Number.find(params[:id])
  end

  def number_type(n)
    if n.num.length == 10
      if Company.find(params[:company]).numbers.nil?
        n.main!
      else
        n.other!
      end
    elsif n.num.length == 12
      n.landline!
    end
    n
  end
end
