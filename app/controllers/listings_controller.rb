class ListingsController < ApplicationController
  before_action :set_garden, only: [:show, :edit, :update, :destroy]
  def show
    @listing = Listing.find(params[:id])
  end

  def index
    @listing = Listing.All
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
  end

  def destroy
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
