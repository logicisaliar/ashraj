class HarmonicDetailsController < ApplicationController
  skip_before_action :authenticate_user!

def index
  @harmonic_details = HarmonicDetail.all
end

end
