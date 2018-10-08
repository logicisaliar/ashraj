class Company < ApplicationRecord
  belongs_to :parent, class_name: "Company", optional: true
  has_one :child, class_name: "Company", foreign_key: :parent_id
  has_many :addresses
  has_many :numbers
  has_many :mails
  has_many :orders
  validates :name, uniqueness: true
end
