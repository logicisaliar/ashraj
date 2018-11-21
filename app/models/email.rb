class Email < ApplicationRecord
  belongs_to :company
  enum primary: [:main, :other]
end
