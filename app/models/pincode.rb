class Pincode < ApplicationRecord
  belongs_to :city
  delegate :state, :to => :city, :allow_nil => true
  validates :pin, uniqueness: true
end
