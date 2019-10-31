class ApplicationController < ActionController::Base

before_action :authenticate_user!
  include Pundit

  after_action :verify_authorized, except: [:index, :overview], unless: :skip_pundit?


  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

      def configure_permitted_parameters
          devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :photo, :email, :password) }
          devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :username, :photo, :email, :password, :current_password) }
      end


private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/  || params[:controller] == 'rentals' || params[:controller] == 'review' || params[:controller] == 'users'
  end

end
