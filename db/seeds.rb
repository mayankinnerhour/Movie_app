require 'json'
require 'open-uri'

url = 'http://www.omdbapi.com?apikey=c9feda2c&s=liv&page=3'
post_ids = URI.open(url).read
# p post_ids
posts = JSON.parse(post_ids)

2.times do |index|
	post_id = posts[index]
	url_post = 'http://www.omdbapi.com?apikey=c9feda2c&s=liv&page=3'
	post_info = URI.open(url_post).read
	post = JSON.parse(post_info)
	# p post
	new_movie = Movie.create!(
		title: post['title'],
		description: post['genre'],
		movie_length: post['runtime'],
		director: post['director'],
		rating: post['ratings'],
		user_id: 1
		)
end