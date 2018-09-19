class StatesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @states = State.all
  end

end
