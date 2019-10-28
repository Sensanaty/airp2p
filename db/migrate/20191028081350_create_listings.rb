class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :price
      t.string :location

      t.timestamps
    end
  end
end
