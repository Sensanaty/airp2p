class Listing < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  
  belongs_to :game
  belongs_to :user
  has_many :rentals
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model

  CONSOLES = ["PS4", "Xbox One", "Nintendo Switch", "PC"]
  validates :platform, inclusion: { in: CONSOLES }

  pg_search_scope :global_search, against: [:platform],
                                  associated_against: { game: [:title] },
                                  using: { tsearch: { prefix: true } }
end
