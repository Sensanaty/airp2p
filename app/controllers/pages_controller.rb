class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @all_listings = Listing.all
    @listings = Listing.order('RANDOM()').limit(15)
  end

  # Temporary routes for showing CSS components. Delete later, along with the associated views
  def list_items_preview
  end

  def reviews_component_preview
  end

  def borrow_lend_item_preview
  end
end
