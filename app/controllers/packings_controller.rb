
class PackingsController < ApplicationController

  skip_before_action :authenticate_user!

  def index
    @packings = Packing.all
  end

end
