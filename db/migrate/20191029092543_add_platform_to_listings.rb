class AddPlatformToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :platform, :string
  end
end
