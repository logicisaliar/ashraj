class CompaniesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def new
    @company = Company.new
    @company_kinds = [[1, "User"], [2, "Trader"], [3, "On Account"]]
  end

  def create
    @company = Company.new(company_params)
    @traders = Company.where(kind: 2)
    unless @company.kind == 3 && @company.parent_id.nil?
      if @company.save!
        redirect_to company_path(@company)
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
    @number = truncate_num(Number.where(company: @company).to_a, 50)
    @email = truncate_mail(Email.where(company: @company).to_a, 50)
  end

  def destroy
  end

  private

  def company_params
    params.require(:company).permit(:name, :kind, :gst, :pan_number, :spl_instructions, :parent_id)
  end

  def set_company
    @company = Company.find(params[:id])
  end

end
