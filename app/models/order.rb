class Order < ApplicationRecord
  belongs_to :company
  has_many :lines
  has_many :items, through: :lines
  belongs_to :transport, optional: true
  belongs_to :user, optional: true
  belongs_to :address
  enum status: [:pending, :completed, :confirmed, :packed, :invoiced, :dispatched, :released]
end
