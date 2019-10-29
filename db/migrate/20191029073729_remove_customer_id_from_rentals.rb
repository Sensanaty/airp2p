class RemoveCustomerIdFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_reference :rentals, :customer_id
  end
end
