class DashboardController < ApplicationController
  def overview
    @user = current_user
    @lends = Rental.where(listing_id: @user.listings.pluck(:id))
  end
end
