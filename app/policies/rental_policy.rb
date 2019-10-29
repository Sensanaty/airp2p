class RentalPolicy < ApplicationPolicy

def create?

end

def show?
  record.customer == user || record.listing.user == user
end

end
