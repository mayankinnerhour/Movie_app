class MoviesController < ApplicationController

  include SlackNotification

  before_action :set_movie, only: %i[ show edit update destroy favorite ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies= Movie.all
    end
  end

  def index
    @movies = Movie.all.by_name(name).old.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    
    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def new
    @movie = current_user.movies.build
  end

  def edit
  end

  def create
    # Time.zone = movie_params[:time_zone]
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
        message = "A new movie #{@movie.title} has been successfully Added!."

      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
        message = "A new movie #{@movie.title} has been successfully Added!."
      end
      # slack_data = { message: message }
      # sendNotification(slack_data)
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to movies_url, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @movie
      redirect_to movies_url, notice: "You favorited #{@movie.title}"
      message = "A new movie #{@movie.title} has been successfully Added to FAVORITES."
    elsif type == "unfavorite"
      current_user.favorites.delete(@movie)
      redirect_to movies_url, notice: "You unfavorited #{@movie.title}"
      message = "A new movie #{@movie.title} has been successfully Removed! from FAVORITES."
    else
      redirect_to movies_url, notice: "Nothing happened."
    end 

    slack_data = { message: message }
    sendNotification(slack_data)

  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :image, :year, :imdb_id, :time_zone, :time)
    end
end
