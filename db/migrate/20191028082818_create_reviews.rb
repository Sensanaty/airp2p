class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :rental, foreign_key: true
      t.integer :rating
      t.text :review_content

      t.timestamps
    end
  end
end
