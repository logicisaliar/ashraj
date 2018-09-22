class TransportsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @transports = Transport.all
  end

  def new
    @transport = Transport.new
  end

  def create
    @transport = Transport.new(transport_params)
    @transport.street = grammify(@transport.street)[-1]
    if @transport.save!
      redirect_to transports_path
    else
      render :new
    end
  end

  private

  def transport_params
    params.require(:transport).permit(:name, :street, :village)
  end
end
