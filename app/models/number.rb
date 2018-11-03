class Number < ApplicationRecord
  belongs_to :company
  enum primary: [:main, :landline, :other]
  validates :num, presence: true
  validates_length_of :num, :minimum => 10, :message => "Please check your entry"
  validates_length_of :num, :maximum => 12, :message => "Please check your entry"


end
