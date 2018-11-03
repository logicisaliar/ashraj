class MailsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_mail, only: [:edit, :update]

  def new
    @mail = Mail.new
  end

  def create
    @mail = Mail.new(mail_params)
    @mail.company = Company.find(params[:company])
    if @mail.save!
      if @mail.company.mails.nil?
        @mail.main!
      else
        @mail.other!
      end
      redirect_to company_path(@mail.company.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @mail.update(mail_params)
    redirect_to company_path(Company.find(params[:company]))
  end

  def index
    @mails = Company.find(params[:company]).mails
  end

  private

  def mail_params
    params.require(:mail).permit(:eadd, :primary, :user_id, :company_id)
  end

  def set_mail
    @mail = Mail.find(params[:id])
  end
end
