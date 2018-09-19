class CitiesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_city, only: [:edit, :update]


  def new
    @states = class_label(State.all)
    @city = City.new
  end

  def create
    @city = City.new(city_params)
    if @city.save!
      redirect_to cities_path
    else
      render :new
    end
  end

  def edit
    @states = class_label(State.all)
  end

  def update
    @city.update(city_params)
    redirect_to cities_path
  end

  def index
    @cities = City.all
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
    sorted = cls.sort_by &:name
    sorted.each do |p|
      return_array << [p.id, "#{p.name} (#{p.code}) "]
    end
    return_array
  end

end
