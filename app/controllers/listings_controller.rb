class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_listing, only: %i[show edit update destroy]
  require 'date'

  def show
    @rental = Rental.new
    @today = Date.today
    authorize @listing
  end

  def index
    @listings = Listing.all
    @listing_map = Listing.geocoded
    @markers = @listing_map.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
    if params[:search]
      if params[:search][:name].present?
        @search_query = params[:search][:name]
        @listings = @listings.global_search(@search_query)
        @title = "Results for \"#{@search_query}\""
      end
      if params[:search][:platform].present?
        @listings = @listings.where(platform: params[:search][:platform])
      end
    end
  end

  def new
    @listing = Listing.new
    authorize @listing
  end

  def create
    @listing = Listing.new(listing_params)
    authorize @listing
    @listing.user = current_user
    if @listing.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    authorize @listing
  end

  def update
    authorize @listing
    @listing.update(listing_params)
    if @listing.save
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  def destroy
    authorize @listing
    @listing.destroy
    redirect_to dashboard_path
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params.require(:listing).permit(:price, :location, :game_id, :platform, :photo)
  end
end
