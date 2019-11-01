require 'faker'
require 'thegamesdb'

# Reset DBs for Seed
Game.destroy_all
User.destroy_all
Listing.destroy_all

puts "NOTE: Due to Faker limitations we can only create 200 UNIQUE games"
puts "\nGenerating a Game table with 200 entries\e[5m...\n\e[25m"

200.times do
  name = Faker::Game.unique.title
  gamedb = Gamesdb.games_by_name(name)
  genre = Faker::Game.genre

  bio = if gamedb == []
          Faker::Lorem.sentence(word_count: 15)
        else
          gamedb[0][:overview]
        end

  image = if gamedb == []
            "https://source.unsplash.com/#{rand(500..600)}x#{rand(490..590)}/?games,gaming"
          else
            gamedb[0][:image]
          end

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
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
      email: email,
      password: "password",
      username: username,
      profile_info: bio,
      first_name: first_name,
      last_name: last_name
  )
end

puts "\nUsers generated\n========"

LOCATIONS = [
    "Astaro Theatro, Sint Jansstraat, Burgwallen-Oude Zijde, Amsterdam, North Holland, The Netherlands",
    "Dam, Dam Square, Centrum, Amsterdam, North Holland, The Netherlands",
    "Albert Heijn, 34, Haarlemmerplein, Haarlemmerbuurt, Amsterdam, North Holland, The Netherlands",
    "139-1, Overtoom, Overtoomse Sluis, Amsterdam, North Holland, Netherlands, 1054HG, The Netherlands",
    "Camping Vliegenbos, 138, Meeuwenlaan, Amsterdam, North Holland, Netherlands, 1022AM, Netherlands",
    "Vrije Universiteit, Campusplein, Zuidas, Amsterdam, North Holland, Netherlands, The Netherlands",
    "Skek, 4, Zeedijk, Burgwallen-Oude Zijde, Amsterdam, North Holland, Netherlands, 1012AX, The Netherlands",
    "EYE Filminstituut, 1, IJpromenade, Centrum, Amsterdam, North Holland, Netherlands, 1031KT, Netherlands",
    "Entree de Borcht, Amstelpark, Buitenveldert, Amsterdam, North Holland, Netherlands, 1083AC, The Netherlands",
    "Aquamarin, Weesp, North Holland, Netherlands, 1382KJ, Netherlands",
    "Groot kinderbad, Grote Speelweide, Amstelveen, North Holland, Netherlands, 1182AD, The Netherlands",
    "4, Koningin Julianalaan, Zanderij, Katwijk, South Holland, Netherlands, 2224EW, Netherlands",
    "Dorpskerk, Gasthuislaan, 's- Gravenzande, 's-Gravenzande, Westland, South Holland, Netherlands",
    "637, Simplonbaan, Hoograven, Utrecht, Netherlands, 3524GK, The Netherlands",
    "City centre, Langstraat, UMCG, Centrum, Groningen, Netherlands, 9713GZ, The Netherlands",
    "WTC (H), Zuidplein, Zuidas, Amsterdam, North Holland, Netherlands, 1077 XV, The Netherlands"
]
PLATFORMS = ["PS4", "Xbox One", "Nintendo Switch", "PC"]

puts "\nGenerating #{LOCATIONS.count} random listings with random users and random locations"

LOCATIONS.each_with_index do |_, index|
  game_id = Game.find(rand(1..200)).id
  user_id = User.find(rand(1..50)).id
  price = rand(2..5)
  Listing.create(
             game_id: game_id,
             user_id: user_id,
             price: price,
             location: LOCATIONS[index],
             platform: PLATFORMS.sample
  )
end

puts "\nListings created"
puts "\n\e[42mSeed File finished running\e[49m.\n"
