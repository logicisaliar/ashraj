class Harmonic < ApplicationRecord
  validates :hsn_end, uniqueness: true
  belongs_to :harmonic_detail
end
