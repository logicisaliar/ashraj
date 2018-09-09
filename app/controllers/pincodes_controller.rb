class PincodesController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_pincode, only: [:edit, :update]

  def new
    @pincode = Pincode.new
  end

  def create
    @pincode = Pincode.new(pincode_params)
    if @pincode.save!
      redirect_to pincodes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @pincode.update(pincode_params)
    redirect_to pincode_path
  end

  def index
    filename = "pincode"
    csv_read(filename)
    @pincodes = Pincode.all
  end

  private

  def pincode_params
    params.require(:pincode).permit(:pin, :city_id)
  end

  def set_pincode
    @pincode = Pincode.find(params[:id])
  end

  # def class_label(cls)
  #   return_array = []
  #   sorted = cls.sort_by &:name
  #   sorted.each do |p|
  #     return_array << [p.id, "#{p.name} (#{p.code}) "]
  #   end
  #   return_array
  # end

    def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    count = 0
    csv.each do |row|
      t = Pincode.new
      t.pin = row['pin']
      t.city_id = row['city_id']
      if (count > 100)
      end
      t.save
      count += 1
    end
  end

end

