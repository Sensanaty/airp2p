class DashboardController < ApplicationController
  def overview
    @user = current_user
  end
end

# Uncomment code when ready to add pundit
   # @user = current_user
   # authorize @user
