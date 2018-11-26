class Brokerage < ApplicationRecord
  belongs_to :order
  belongs_to :company
end
