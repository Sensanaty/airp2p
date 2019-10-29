# This seed file is using faker and only pulls title, genre and platform.

require 'faker'

puts "cleaning the database..."
Game.destroy_all

puts "creating 100 games..."

counter = 1
500.times do
  game = {
    title: Faker::Game.title,
    genre: Faker::Game.genre,
    platform: Faker::Game.platform,
  }
  Game.create(game)
  puts "Saving game #{counter}: #{game[:title]}"
  counter += 1
end

puts "Finished"