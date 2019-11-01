class RentalPolicy < ApplicationPolicy

def create?
  record.user != user
end

def show?
  record.customer_id == user.id || record.listing.user == user
end

end
