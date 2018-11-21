class Company < ApplicationRecord
  has_many :lines
  has_many :orders, through: :lines
  belongs_to :parent, class_name: "Company", optional: true
  has_one :child, class_name: "Company", foreign_key: :parent_id
  has_many :addresses
  has_many :numbers
  has_many :emails
  has_many :orders
  validates :name, uniqueness: true
end
