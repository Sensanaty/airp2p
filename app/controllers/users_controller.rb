class UsersController < ApplicationController
  def show
    # user and user_profile need different instance variables here for
    # authentication  and data display purposes
    @user_profile = User.find(params[:id])
    @user = current_user
    authorize @user
  end
end
