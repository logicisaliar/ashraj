class TypesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @types = Type.all
  end

end
