class Client::OuterpackingsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @outerpacking = Outerpacking.new
  end

  def create
    @outerpacking = Outerpacking.new(outerpacking_params)
    @outerpacking.order = Order.find(params[:order_id])
    if @outerpacking.save!
      redirect_to client_order_path(@outerpacking.order.id)
    else
      render :new
    end
  end

  def index
    @outeperackings = Outerpacking.all
  end


  private

  def outerpacking_params
    params.require(:outerpacking).permit(:outer_id, :quantity)
  end

end
