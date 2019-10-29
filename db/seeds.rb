require 'faker'

# Reset DBs for Seed
Game.destroy_all
User.destroy_all
Listing.destroy_all

puts "NOTE: Due to Faker limitations we can only create 200 UNIQUE games"
puts "\nGenerating a Game table with 200 entries\e[5m...\n\e[25m"

200.times do
  name = Faker::Game.unique.title
  genre = Faker::Game.genre
  bio = Faker::Lorem.sentence(word_count: 15)
  image = 'https://source.unsplash.com/collection/3368504'
  Game.create(
          title: name,
          description: bio,
          genre: genre,
          image: image
  )
end

puts "\nGames generated\n========"

puts "\nGenerating 50 random users"
50.times do
  email = Faker::Internet.unique.email
  username = "#{Faker::Games::Fallout.character}#{Faker::Games::SuperSmashBros.fighter}".gsub(/\s+/, "").capitalize
  bio = Faker::Lorem.sentence(word_count: 10)
  avatar = Faker::Avatar.image
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
      email: email,
      password: "password",
      username: username,
      profile_info: bio,
      photo: avatar,
      first_name: first_name,
      last_name: last_name
  )
end

puts "\nUsers generated\n========"

puts "\nGenerating 20 random listings with random users and random locations"

LOCATIONS = %w(Amsterdam Berlin Jakarta Bali Paris London Belgrade)
PLATFORMS = ["PS4", "Xbox One", "Nintendo Switch", "PC"]

20.times do
  game_id = Game.find(rand(1..200)).id
  user_id = User.find(rand(1..50)).id
  price = rand(2..5)
  Listing.create(
             game_id: game_id,
             user_id: user_id,
             price: price,
             location: LOCATIONS.sample,
             platform: PLATFORMS.sample
  )
end

puts "\nListings created"
puts "\n\e[42mSeed File finished running\e[49m.\n"
