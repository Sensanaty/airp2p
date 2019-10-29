class ListingPolicy < ApplicationPolicy

  def show?
    return  true
  end

  def new?
    create?
  end

  def create?
    record.user == user
  end

  def edit
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

end
