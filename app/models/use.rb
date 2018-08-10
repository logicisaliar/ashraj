class Use < ApplicationRecord
  validates :name, uniqueness: true
end
