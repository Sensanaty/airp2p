require 'faker'
require 'rest-client'
require 'dotenv'
require 'pp'
Dotenv.load

def get_game_genres
  puts "\e[34mGetting game genres...\e[0m"
  url = "https://api.thegamesdb.net/v1/Genres?apikey=#{ENV['GAMESDB_API_KEY']}"
  response = RestClient.get(url)
  data = JSON.parse(response.body)
  genres = data["data"]["genres"]

  usable_genres = {}

  # Convert to friendly hash for use in this seeding app
  genres.each do |genre|
    usable_genres[genre[1]["id"]] = genre[1]["name"]
  end

  puts "\e[92mGot Genres!\e[0m\n\n"
  return usable_genres
end

$genres = get_game_genres

def main
  platform_ids = [["1", "PC"], ["4919", "PS4"], ["4920", "Xbox One"], ["4971", "Nintendo Switch"]] # num = API platform ID
  generate_users()

  platform_ids.each do |platform|
    puts "\e[33mGetting games for #{platform[1]}...\e[0m"
    games = get_games(platform[0])

    if (platform[0] != "1")
      pp "games: #{games}"
    end

    games.each do |game|
      add_game_to_db(game)
    end
    puts "\e[92mFinished adding #{platform} games to database.\e[0m\n\n"
    generate_listings(platform[1])
  end

  puts "\n\e[32m+=+=+=+=+=+=+=+=+=+=+=+=+=+\e[0m"
  puts "\e[32m|| \e[42;97mSEEDING DATABASE DONE\e[0m \e[32m||"
  puts "\e[32m+=+=+=+=+=+=+=+=+=+=+=+=+=+\e[0m\n"
end


def get_games(platform_id)
  url = "https://api.thegamesdb.net/v1/Games/ByPlatformID?apikey=#{ENV['GAMESDB_API_KEY']}&id=#{platform_id}&fields=overview%2Cgenres&page=3"
  response = RestClient.get(url)
  data = JSON.parse(response.body)
  games = data["data"]["games"]
  puts "\e[92mGot games!\e[0m\n\n"
  return games
end

def add_game_to_db(game)
  # pp game
  puts "\e[34mBuilding #{game["game_title"]} object for database...\e[0m"

  game_for_db = {
    title: game["game_title"],
    description: game["overview"],
    genre: get_game_genre(game["genres"]),
    image: get_game_image(game["id"])
  }
  puts "\e[34mAdding #{game["game_title"]} to database...\e[0m"
  Game.create(game_for_db)
  # pp game_for_db
  puts "\e[92mAdded #{game["game_title"]} to database!\e[0m\n\n"
end

def get_game_genre(genre_ids_array)
  primary_genre = "Unknown"
  primary_genre_id = 0

  if genre_ids_array.kind_of?(Array)
    primary_genre_id = genre_ids_array[0]
  end
  
  if primary_genre_id != 0
    primary_genre = $genres[primary_genre_id]
  end

  return primary_genre
end

def get_game_image(game_id)
  api_url = "https://api.thegamesdb.net/v1/Games/Images?apikey=#{ENV['GAMESDB_API_KEY']}&games_id=#{game_id}"
  response = RestClient.get(api_url)
  data = JSON.parse(response.body)
  image_metadata_array = data["data"]["images"][game_id.to_s]
  boxart_front_metadata = image_metadata_array.select{|img| img["side"] == "front"}[0]
  boxart_front_filename = boxart_front_metadata["filename"]
  image_url = "https://cdn.thegamesdb.net/images/medium/#{boxart_front_filename}"
  # raw_data = RestClient::Request.execute(
  #   method: :get,
  #   url: image_url,
  #   raw_response: true)
  #   puts Dir.pwd
  # file = File.open("test.png")
end

def generate_users
  puts "\e[34mGenerating 50 random users...\e[0m"
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
  puts "\e[92m50 random users added to database!\e[0m\n\n"
end

def generate_listings(platform_name)
  locations = [
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
  
  puts "\nGenerating #{locations.count} random listings with random users and random locations"
  
  locations.each_with_index do |_, index|
    recently_added_games = Game.last(20)
    game_id = recently_added_games.sample["id"]
    user_id = User.find(rand(1..50)).id
    price = rand(2..5)

    listing_object = {
      game_id: game_id,
      user_id: user_id,
      price: price,
      location: locations[index],
      platform: platform_name      
    }

    Listing.create(listing_object)
  end

  puts "\e[92mFinished generating random listings!\e[0m\n\n"
end

main
# get_game_image("18865")