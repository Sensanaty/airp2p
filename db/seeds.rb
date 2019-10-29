genres = JSON.parse(open("db/json/genres.json").read)
read_games = open("db/json/games.json").read
games = JSON.parse(read_games)

puts "\nGenerating a Game table with 500 entries\e[5m...\n\e[25m"

games.each do |game|
  genre_array = genres.find { |hash| hash["id"] == game["genres"].first }
  title = game["name"]
  description = game["summary"]
  platform = game["platforms"]
  Game.create(title: title, description: description, genre: genre_array["slug"], platform: platform)
end

puts "\nGames generated"

# User generation
require 'faker'

puts "\nGenerating 50 random users"
50.times do
  email = Faker::Internet.unique.email
  username = "#{Faker::Games::Fallout.character}#{Faker::Games::SuperSmashBros.fighter}".gsub(/\s+/, "").capitalize
  bio = Faker::Lorem.sentence(word_count: 10)
  avatar = Faker::Avatar.image
  User.create(email: email, password: "password",
              username: username, profile_info: bio, photo: avatar)
end

puts "\nUsers generated"

puts "\n\e[42mSeed File finished running\e[49m.\n"