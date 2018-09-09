class State < ApplicationRecord
  validates :name, uniqueness: true
  has_many :pincodes, :through => :cities
  has_many :cities
end
