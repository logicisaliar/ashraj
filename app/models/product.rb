class Product < ApplicationRecord
  has_and_belongs_to :use
  has_and_belongs_to :category
  belongs_to :type
  belongs_to :harmonic
end
