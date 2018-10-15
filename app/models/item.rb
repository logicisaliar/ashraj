class Item < ApplicationRecord
  belongs_to :product
  belongs_to :packing
  belongs_to :order, optional: true
end
