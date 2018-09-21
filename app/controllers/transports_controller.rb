class TransportsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @transports = Transport.all
  end
end
