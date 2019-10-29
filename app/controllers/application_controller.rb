class ApplicationController < ActionController::Base

# Uncomment these lines once ready to use
# before_action :authenticate_user!
#   include Pundit

  # Uncomment only first line when ready to deploy
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?



# private

#   def skip_pundit?
#     devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
#   end

end
