require 'csv'

class HarmonicDetailsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @harmonic_detail = HarmonicDetail.new
  end

  def create
    @harmonic_detail = HarmonicDetail.new(harmonic_detail_params)
    hsn_scrapper(@harmonic_detail)
    if @harmonic_detail.save
      redirect_to harmonic_details_path
    else
      render 'new'
    end

  end

  def index
    filename = "harmonic_detail"
    csv_read(filename)
    @harmonic_details = HarmonicDetail.all.sort_by &:hsn_chapter
    @harmonic_details.each do |h|
      hsn_scrapper(h)
    end
  end

  private

  def hsn_scrapper(h)
    url = "http://www.cybex.in/HS-Codes/hs-#{h.hsn_chapter}.aspx"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('#ctl00_BodyContents_subheading_gridview_ctl02_SUBHEADING_DESCRIPTION').each do |element|
      h.description = element.text.strip
    end
  end

  def csv_read(filename)
    csv_text = File.read(Rails.root.join('lib', 'seeds', "#{filename}.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
    csv.each do |row|
      t = HarmonicDetail.new
      t.hsn_chapter = row['hsn_chapter']
      t.gst = row['gst']
      t.save
    end
  end

end
