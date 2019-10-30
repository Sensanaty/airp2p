class RentalsController < ApplicationController
  def show
    @rental = Rental.find(params[:id])
    # authorize @rental
  end

  def create
    @rental = Rental.new(rental_params)
    # authorize @rental
    @rental.user = current_user
    @listing = Listing.find(params[:listing_id])
    @rental.listing = @listing

    if @rental.save
      redirect_to dashboard_path
    else
      render :new
    end
  end


  def rental_params
    params.require(:rental).permit(:start_date, :end_date)
  end
end
