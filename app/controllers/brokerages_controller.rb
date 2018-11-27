class BrokeragesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_brokerage, only: [:edit, :update]

  def edit
  end

  def index
    @brokerages = Brokerage.all
  end

  def show
    @brokerage = Brokerage
  end

  private

  def set_brokerage
    @brokerage = Brokerage.find(params[:id])
  end

  # def email_params
  #   params.require(:brokerage).permit(:eadd, :primary, :user_id, :company_id)
  # end

end
