class Order < ApplicationRecord
  belongs_to :company
  belongs_to :item
  belongs_to :transport
  belongs_to :user
  belongs_to :address
end
