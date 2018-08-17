require 'csv'

class HarmonicsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @harmonic = Harmonic.new
  end

  def create
    @harmonic = Harmonic.new(harmonic_params)
    @harmonic.hsn = hsn_eight_digit(@harmonic.hsn)
    # @harmonic.description = hsn_scrapper(@harmonic)
    if @harmonic.save
      redirect_to harmonics_path
    else
      render 'new'
    end

  end

  def index
    filename = "harmonic"
    csv_read(filename)
    @harmonics = Harmonic.all.sort_by &:hsn
    # @harmonics.each do |h|
    #   hsn_scrapper(h)
    # end
  end

  private

  def harmonic_params
    params.require(:harmonic).permit(:hsn)
  end

    def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = Harmonic.new
      t.hsn = row['hsn']
      t.save
    end
  end

  def hsn_scrapper(h)
    url = "http://www.cybex.in/HS-Codes/hs-#{h.hsn/10000}.aspx"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('#ctl00_BodyContents_subheading_gridview_ctl02_SUBHEADING_DESCRIPTION').each do |element|
      h.description = element.text.strip
    end
  end

  def hsn_eight_digit(h)
    if h/10000 == 0
      h = h * 10000
    elsif h/100 == 0
      h = h * 100
    end
    return h
  end
  # def harmonic_return(h)
  #   @hsns = []
  #   @hsns << "#{h.harmonic_detail.hsn_chapter}#{h.hsn_end}"
  #   @hsns.sort!
  # end

end
