class DashboardController < ApplicationController
  def overview
    @user = current_user
  end
end
