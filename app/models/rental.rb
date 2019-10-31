class Rental < ApplicationRecord
  belongs_to :listing
  belongs_to :user, foreign_key: "customer_id"
  after_create :set_rental_price
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def set_rental_price
    start_date = self.start_date
    end_date = self.end_date
    days = end_date - start_date + 1
    total_price = days * self.listing.price
    self.rental_fee = total_price
    self.save
  end

  private
  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

end


