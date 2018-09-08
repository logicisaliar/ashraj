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
    filename = "city"
    csv_read(filename)
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

    def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = State.new
      t.name = row['name']
      t.state_id = row['state_id']
      t.save
    end
  end

end
