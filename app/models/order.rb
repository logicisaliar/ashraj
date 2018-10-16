class Order < ApplicationRecord
  belongs_to :company
  has_many :items
  belongs_to :transport
  belongs_to :user, optional: true
  belongs_to :address
  enum status: [:pending, :completed, :confirmed, :packed, :invoiced, :dispatched, :released]
end
