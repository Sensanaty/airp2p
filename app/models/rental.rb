class Rental < ApplicationRecord
  belongs_to :listing
  belongs_to :user, foreign_key: "customer_id"
  after_create :set_rental_price

  def set_rental_price
    start_date = self.start_date
    end_date = self.end_date
    days = end_date - start_date + 1
    total_price = days * self.listing.price
    self.rental_fee = total_price
    self.save
  end

end


