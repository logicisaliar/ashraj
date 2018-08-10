require 'csv'

class UsesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    filename = "use"
    csv_read(filename)
    @uses = Use.all
  end

  private

  def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Use.new
      t.name = row['name']
      t.save
    end
  end

end

