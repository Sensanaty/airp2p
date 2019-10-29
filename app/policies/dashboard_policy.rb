class DashboardPolicy < ApplicationPolicy

  def overview?
    record == @user
  end
end
