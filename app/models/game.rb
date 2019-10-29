class Game < ApplicationRecord
  validates :title, presence: true
end
