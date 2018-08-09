class HarmonicsController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :set_harmonic, only: [:show, :edit, :update, :destroy]

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
    @harmonics = Harmonic.all
  end

  private

  def set_harmonic
    @harmonic = Harmonic.find(params[:id])
  end

  def harmonic_params
    params.require(:harmonic).permit(:hsn_end, :harmonic_detail_id)
  end

  def hsn_chapters_sorted(harmonic_details)
    hsn_chapters = []
    harmonic_details.each do |h|
      hsn_chapters << h.hsn_chapter
    end
    return hsn_chapters.sort!
  end
end
