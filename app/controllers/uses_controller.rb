require 'csv'

class UsesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @uses = Use.all
  end

end

