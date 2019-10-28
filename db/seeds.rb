require 'json'

genres = JSON.parse(open("json/genres.json").read)
genres.each_with_index do |_, index|
  genre_hash = {
      id: index,
      name: genres[index]["slug"]
  }
  genre_hash[:name]
end

read_games = open("db/json/games.json").read
games = JSON.parse(read_games)
p games[0]["name"]
p games[0]["summary"]
p games[0]["platforms"]
puts "\n\n\n"
games.each_with_index do |_, index|
  puts "Line #{index + 1}"
  p "Genre:"
  p "Title: #{games[index]["name"]}"
  p "Description: #{games[index]["summary"]}"
  p "Genre: #{}"
  p "Platform: #{games[index]["platforms"]}"
  puts "=========="
  Game.create(title: games[index]["name"], description: games[index]["summary"], genre: genres[index]["name"], platform: games[index]["platforms"])
end

puts "\n\n============="
puts "!!!!!!!!!!!!!"
puts "!!!SUCCESS!!!"
puts "!!!!!!!!!!!!!"
puts "============="