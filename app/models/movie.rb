class Movie < ApplicationRecord
	searchkick

	belongs_to :user
	has_many :favorite_movies
	has_many :favorited_by, through: :favorite_movies, source: :user # the actual users favoriting a movie
	has_many :reviews
	has_one_attached :image

end
