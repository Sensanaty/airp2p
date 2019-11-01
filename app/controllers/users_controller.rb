class UsersController < ApplicationController
  def show
    # user and user_profile need different instance variables here for
    # authentication  and data display purposes
    @user_profile = User.find(params[:id])
    @user = current_user
    @listings_id = @user_profile.listings.pluck(:id)
    @rentals_id = Rental.where(listing_id: @listings_id[0]).pluck(:id)
    @reviews = Review.where(rental_id: @rentals_id)
    authorize @user
  end
end
