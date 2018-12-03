class OuterpackingsController < ApplicationController

  before_action :set_outerpacking, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    if @outerpacking.update(outerpacking_params)
      redirect_to client_order_path(@outerpacking.order.id)
    else
      render :edit
    end
  end

  def destroy
    o = Order.find(params[:order])
    @outerpacking.destroy
    redirect_to client_order_path(o)
  end


  private

  def set_outerpacking
    @outerpacking = Outerpacking.find(params[:id])
  end

  def outerpacking_params
    params.require(:outerpacking).permit(:outer_id, :quantity)
  end

end
