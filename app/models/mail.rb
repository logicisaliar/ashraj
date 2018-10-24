class Mail < ApplicationRecord
  belongs_to :company, optional: true
  enum primary: [:main, :other]
end
