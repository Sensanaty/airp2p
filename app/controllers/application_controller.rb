class ApplicationController < ActionController::Base

before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?
  include Pundit

after_action :verify_authorized, except: %i[index overview], unless: :skip_pundit?

private

def skip_pundit?
  devise_controller? ||
    params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
end

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name, :photo])
  end
end
