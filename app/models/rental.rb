class Rental < ApplicationRecord
  belongs_to :listing
  belongs_to :user, foreign_key: "customer_id"
end
