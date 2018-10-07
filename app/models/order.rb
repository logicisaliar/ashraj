class Order < ApplicationRecord
  belongs_to :company
  belongs_to :item, optional: true
  belongs_to :transport, optional: true
  belongs_to :user, optional: true
  belongs_to :address, optional: true
end
