class AddCustomerToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :customer, foreign_key: { to_table: :users }
  end
end
