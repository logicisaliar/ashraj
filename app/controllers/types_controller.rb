class TypesController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    filename = "type"
    csv_read(filename)
    @types = Type.all
  end

  private

  def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Type.new
      t.name = row['name']
      t.save
    end
  end

end
