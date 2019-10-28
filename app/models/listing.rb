class Listing < ApplicationRecord
  has_one :game
  belongs_to :user
  has_many :rentals
end
