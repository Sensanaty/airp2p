class PagesController < ApplicationController
  def home
    @listings = Listing.all
    # @top_listings = Listing.order(:price).limit(10)
  end

  # Temporary routes for showing CSS components. Delete later, along with the associated views
  def list_items_preview
  end

  def reviews_component_preview
  end
end
