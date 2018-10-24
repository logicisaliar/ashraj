class Number < ApplicationRecord
  belongs_to :company, optional: true
  enum primary: [:main, :landline, :other]
end
