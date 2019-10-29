class DashboardController < ApplicationController
  # overview action does not require pundit - only own
  # dashboard can be queried
  def overview
    @user = current_user
  end
end
