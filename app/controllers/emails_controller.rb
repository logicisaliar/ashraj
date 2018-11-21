class EmailsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_email, only: [:edit, :update]

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)
    @email.company = Company.find(params[:company])
    if @email.save!
      if @email.company.emails.nil?
        @email.main!
      else
        @email.other!
      end
      redirect_to company_path(@email.company.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @email.update(email_params)
    redirect_to company_path(Company.find(params[:company]))
  end

  def index
    @emails = Company.find(params[:company]).emails
  end

  private

  def email_params
    params.require(:email).permit(:eadd, :primary, :user_id, :company_id)
  end

  def set_email
    @email = Email.find(params[:id])
  end
end
