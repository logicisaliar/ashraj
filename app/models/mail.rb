class Mail < ApplicationRecord
  belongs_to :company
  enum primary: [:main, :other]
end
