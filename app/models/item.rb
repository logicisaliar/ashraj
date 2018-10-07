class Item < ApplicationRecord
  belongs_to :product
  has_many :orders
  belongs_to :packing
end
