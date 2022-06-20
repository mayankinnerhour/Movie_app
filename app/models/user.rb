class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies
  has_many :favorite_movies
  has_many :favorites, through: :favorite_movies, source: :movie # the actual movies a user favorites
  has_many :reviews, dependent: :destroy

end
