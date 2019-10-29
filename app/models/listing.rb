class Listing < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :rentals
end
