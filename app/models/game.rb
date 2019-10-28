class Game < ApplicationRecord
  validates :title, presence: true
  validates :platform, presence: true
end
