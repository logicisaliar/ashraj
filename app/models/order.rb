class Order < ApplicationRecord
  belongs_to :company
  has_many :items
  has_many :outerpackings
  has_one :brokerage
  belongs_to :transport
  belongs_to :user, optional: true
  belongs_to :address
  enum status: [:pending, :completed, :confirmed, :packed, :invoiced, :dispatched, :released, :cancelled]
end
