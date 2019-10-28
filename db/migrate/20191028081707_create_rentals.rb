class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :listing, foreign_key: true
      t.references :customer_id, index: true, foreign_key: { to_table: :users }
      t.integer :rental_fee
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
