class City < ApplicationRecord
  validates_uniqueness_of :name, scope: :state_id
  belongs_to :state
  has_many :pincodes
end
