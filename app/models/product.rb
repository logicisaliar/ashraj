class Product < ApplicationRecord
  has_and_belongs_to_many :use
  has_and_belongs_to_many :category
  has_many :items
  belongs_to :type
  belongs_to :harmonic
end
