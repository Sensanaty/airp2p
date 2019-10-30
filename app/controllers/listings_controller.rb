class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  def show
    @rental = Rental.new
  end

  def index
    @listings = Listing.all
    @listing_map = Listing.geocoded

    @markers = @listing_map.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude
      }
    end

    if params[:search]
      @search_query = params[:search][:name]
      @listings = @listings.global_search(@search_query)
      # @listings = Listing.joins(:games).where('title ILIKE ?', '%' + @search_query + '%' )
      @title = "Results for \"#{@search_query}\""
    end
  end

  def new
    # authorize listing # uncomment when required
    @listing = Listing.new
  end

  def create
    # authorize listing # uncomment when required
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    # authorize listing # uncomment when required
  end

  def update
    # authorize listing # uncomment when required
    @listing.update(listing_params)
    if @listing.save
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    # authorize listing # uncomment when required
    @listing.destroy
    redirect_to dashboard_path
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:price, :location, :game_id, :platform)
  end
end
