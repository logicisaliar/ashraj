class MailsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_mail, only: [:edit, :update]

  def new
    @mail = Mail.new
  end

  def create
    @mail = Mail.new(mail_params)
    if @mail.save!
      redirect_to mails_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @mail.update(mail_params)
    redirect_to mail_path
  end

  def index
    @mails = Mail.all
  end

  private

  def mail_params
    params.require(:mail).permit(:eadd, :primary, :user_id, :company_id)
  end

  def set_mail
    @mail = Mail.find(params[:id])
  end
end
