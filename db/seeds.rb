require 'json'

read_genres = open("db/genres.json").read
genres = JSON.parse(read_genres)

read_games = open("db/genres.json").read
games = JSON.parse(read_games)
games.each_with_index do |game, index|
  Game.create(title: game[:name], description: game[:summary], genre: genres[index]["name"], platform: game["platform"])
end
