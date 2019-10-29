class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  def show
  end

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
    if @pet.save
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to dashboard_path
  end

  private

  def set_garden
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:price, :location, :game_id, :user_id)
  end
end
