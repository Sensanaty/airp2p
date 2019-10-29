class ReviewPolicy < ApplicationPolicy

  def create?
    record.rental.customer == user
  end

  def edit?
    update?
  end

  def update?
    record.rental.customer == user
  end

  def destroy?
    record.rental.customer == user
  end

end
