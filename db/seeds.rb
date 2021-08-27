# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)

require "open-uri"
require "json"

def url(attempt)
  url = "http://tmdb.lewagon.com/movie/#{attempt}"
  user_serialized = URI.open(url).read
  parsed = [JSON.parse(user_serialized)]
  json = parsed.first
  results = json["results"]
  results.each do |movie|
    Movie.create(title: movie["original_title"], overview: movie["overview"], poster_url: movie["poster_path"], rating: movie["vote_average"])
  end
  # test if word is in dictionary
end

options = ["now_playing", "popular", "top_rated", "upcoming"]

options.each do |option|
  url(option)
end
# Movie.create(title: url(option), overview: "", poster_url: "", rating: "")
