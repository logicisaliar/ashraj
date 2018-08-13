class Category < ApplicationRecord
  has_and_belongs_to :product
  validates :name, uniqueness: true
end
