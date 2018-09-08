class CitiesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_city, only: [:update]


  def new
    @states = class_label(State.all)
    @city = City.new
  end

  def edit
    @states = class_label(State.all)
  end

  def index
  end

  private

  def city_params
    params.require(:city).permit(:name, :state_id)
  end

  def set_city
    @city = City.find(params[:id])
  end

  def class_label(cls)
    return_array = []
    cls.each do |p|
      return_array << [p.id, "#{p.code} - #{p.name}"]
    end
    return_array
  end
end
