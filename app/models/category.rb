class Category < ApplicationRecord
  has_and_belongs_to_many :product
  validates :name, uniqueness: true
end
