class AddTimeToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :time, :datetime
  end
end
