class Mail < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company, optional: true
  enum primary: [:main, :other]
end
