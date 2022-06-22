class AddYearToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :imdb_id, :string
    add_column :movies, :poster, :string
  end
end
