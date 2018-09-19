class CompaniesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save!
      redirect_to companies_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to host_company_path(@company)
    else
      render :edit
    end
  end

  def index
    @companies = Company.all
  end

  def show

  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:type, :street, :pincode_id, :company_id)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

end
