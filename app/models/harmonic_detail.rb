class HarmonicDetail < ApplicationRecord
  validates :hsn_chapter, uniqueness: true
  has_many :harmonics
end
