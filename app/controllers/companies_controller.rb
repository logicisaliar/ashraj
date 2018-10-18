class CompaniesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def new
    @company = Company.new
    @company_kinds = [[1, "Trader"], [2, "User"], [3, "On Account"]]
  end

  def create
    @company = Company.new(company_params)
    @traders = Company.where(kind: "Trader")
    unless @company.kind == 3 && @company.parent_id.nil?
      if @company.save!
        redirect_to companies_path
      end
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
    params.require(:company).permit(:name, :kind, :gst, :pan_number, :spl_instructions)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

end
