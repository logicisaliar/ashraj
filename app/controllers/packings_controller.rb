require 'csv'

class PackingsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    filename = "packing"
    csv_read(filename)
    @packings = Packing.all
  end

  private

  def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Packing.new
      t.rebate = row['rebate']
      t.pack_size = row['pack_size']
      t.sample = row['sample']
      t.save
    end
  end
end
