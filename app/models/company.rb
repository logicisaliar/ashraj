class Company < ApplicationRecord
  belongs_to :parent, class_name: "Company", optional: true
  has_one :child, class_name: "Company", foreign_key: :parent_id
  has_many :addresses
  validates :name, uniqueness: true
  enum primary: [:main, :landline, :other]
end
