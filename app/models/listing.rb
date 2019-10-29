class Listing < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :rentals

  consoles = ["PS4", "Xbox One", "Nintendo Switch", "PC"]
  validates :platform, inclusion: { in: consoles }
end
