class ApplicationController < ActionController::Base

before_action :authenticate_user!
  include Pundit

  after_action :verify_authorized, except: [:index, :overview], unless: :skip_pundit?


private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/  || params[:controller] == 'rentals' || params[:controller] == 'review' || params[:controller] == 'users'
  end

end
