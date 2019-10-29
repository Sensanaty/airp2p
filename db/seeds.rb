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

puts "\n\e[42mSeed File finished running"