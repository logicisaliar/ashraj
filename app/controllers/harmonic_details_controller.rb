require 'open-uri'
require 'nokogiri'

class HarmonicDetailsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_harmonic_detail, only: [:show, :edit, :update, :destroy]

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
    @harmonic_details = HarmonicDetail.all
  end

  private

  def set_harmonic_detail
    @harmonic_detail = HarmonicDetail.find(params[:id])
  end

  def harmonic_detail_params
    params.require(:harmonic_detail).permit(:gst, :hsn_chapter)
  end

  def hsn_scrapper(h)
    url = "http://www.cybex.in/HS-Codes/hs-#{@harmonic_detail.hsn_chapter}.aspx"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('#ctl00_BodyContents_subheading_gridview_ctl02_SUBHEADING_DESCRIPTION').each do |element|
      h.description = element.text.strip
    end
  end

end
