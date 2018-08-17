require 'csv'

class HarmonicsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    harmonic_details = HarmonicDetail.all
    @hsn_chapters = hsn_chapters_sorted(harmonic_details)
    @harmonic = Harmonic.new
  end

  def create
    @harmonic = Harmonic.new(harmonic_params)
    if @harmonic.save
      redirect_to harmonics_path
    else
      render 'new'
    end

  end

  def index
    filename = "harmonic"
    csv_read(filename)
    @harmonics = Harmonic.all.sort_by &:harmonic_detail_id
  end

  private

  def harmonic_params
    params.require(:harmonic).permit(:hsn_end, :harmonic_detail_id)
  end

    def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Harmonic.new
      t.harmonic_detail_id = row['harmonic_detail_id']
      t.hsn_end = row['hsn_end']
      t.save
    end
  end

  def harmonic_return(h)
    @hsns = []
    @hsns << "#{h.harmonic_detail.hsn_chapter}#{h.hsn_end}"
    @hsns.sort!
  end

  def hsn_chapters_sorted(harmonic_details)
    hsn_chapters = []
    harmonic_details.each do |h|
      hsn_chapters << h.hsn_chapter
    end
    return hsn_chapters.sort!
  end
end
