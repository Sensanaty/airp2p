class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.string :platform
      t.string :image

      t.timestamps
    end
  end
end
