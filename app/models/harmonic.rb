class Harmonic < ApplicationRecord
  validates :hsn, uniqueness: true
  has_many :products
end
