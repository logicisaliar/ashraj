class Address < ApplicationRecord
  belongs_to :company
  belongs_to :pincode
  validates :street, uniqueness: true
end
