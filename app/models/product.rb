class Product < ApplicationRecord
  has_and_belongs_to_many :use
  has_and_belongs_to_many :category
  belongs_to :type
  belongs_to :harmonic
end
