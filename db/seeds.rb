require 'faker'

# Reset DBs for Seed
Game.destroy_all
User.destroy_all

puts "NOTE: Due to Faker limitations we can only create 200 UNIQUE games"
puts "\nGenerating a Game table with 200 entries\e[5m...\n\e[25m"

200.times do
  name = Faker::Game.unique.title
  genre = Faker::Game.genre
  platform = Faker::Game.platform
  bio = Faker::Lorem.sentence(word_count: 15)
  image = 'https://picsum.photos/150/190'
  Game.create(
          title: name,
          description: bio,
          genre: genre,
          platform: platform,
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

  User.create(
      email: email,
      password: "password",
      username: username,
      profile_info: bio,
      photo: avatar)
end

puts "\nUsers generated"
puts "\n\e[42mSeed File finished running\e[49m.\n"
