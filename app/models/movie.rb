class Movie < ApplicationRecord
	searchkick
	
	belongs_to :user
	has_many :reviews
	has_one_attached :image

end
