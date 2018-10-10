class Line < ApplicationRecord
  belongs_to :order
  belongs_to :item
end
