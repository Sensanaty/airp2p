class RemovePlatformFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :platform, :string
  end
end
