class Address < ApplicationRecord
  belongs_to :company
  has_many :orders
  belongs_to :pincode
  validates :street, uniqueness: true
end
