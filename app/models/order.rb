class Order < ApplicationRecord
  belongs_to :company
  has_many :lines
  has_many :items, through: :lines
  belongs_to :transport, optional: true
  belongs_to :user, optional: true
  belongs_to :address, optional: true
  enum status: [:pending, :complete, :confrimed, :packed, :invoiced, :dispatched, :released]
end
