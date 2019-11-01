class RentalsController < ApplicationController
  def show
    @rental = Rental.find(params[:id])
    # authorize @rental
    @review = Review.new()
    #@rental_fee = @rental.rental_fee
  end

  def create
    @rental = Rental.new(rental_params)
    # authorize @rental
    @rental.user = current_user
    @listing = Listing.find(params[:listing_id])
    @rental.listing = @listing
    if @rental.save
      respond_to do |format|
        format.html { redirect_to listing_path(@listing) }
        format.js
      end
      # redirect_to rental_path(@rental)
    else
      respond_to do |format|
        format.html { render 'listing/show' }
        format.js  # <-- idem
      end
      #render :new
    end
  end


  def rental_params
    params.require(:rental).permit(:start_date, :end_date)
  end
end
