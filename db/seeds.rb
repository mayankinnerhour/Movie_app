require 'json'
require 'open-uri'

url = 'http://www.omdbapi.com?apikey=c9feda2c&s=lov&page=3'
movie_id = URI.open(url).read
# p movie_id
movies = JSON.parse(movie_id)

5.times do |index|
	movie_id = movies[index]
	url_movie = 'http://www.omdbapi.com?apikey=c9feda2c&s=lov&page=3'
	movie_info = URI.open(url_movie).read
	movie = JSON.parse(movie_info)
	# p movie
	new_movie = Movie.create!(
		title: movie["Search"][index]["Title"],
		description: movie["Search"][index]["Type"],
		movie_length: movie["Search"][index]["Runtime"],
		director: movie["Search"][index]["Director"],
		rating: movie["Search"][index]["Ratings"],
		year: movie["Search"][index]["Year"],
		imdb_id: movie["Search"][index]["imdbID"],
		user_id: 1
		)

	# p new_movie
end