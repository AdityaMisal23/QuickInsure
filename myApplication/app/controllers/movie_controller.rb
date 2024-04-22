class MovieController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def search_a_movie
    @movies = Movie.where("name like ?", "%#{(params[:name]).upcase}%")
    render json: @movies
  end

  # its a testing api
  def get_top_todays_movies
    top = 1
    movie_name = Movie.select("movies.name , sum(shows.booked_tickets) as bookings")
      .joins(shows: { screen: { theater: :location } })
      .where(locations: { id: 5 })
      .where(shows: { show_date: Date.today })
      .group("movies.name")
      .order("sum(shows.booked_tickets) DESC")
      .limit(3)
      .as_json
    render json: movie_name
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      render json: { message: "Movie added" }
    else
      render json: { message: "Failed" }
    end
  end

  def find_movie_using_genre
    @movies = Movie.where("genre = ?", params[:genre])
    if @movies.length > 0
      render json: @movies
    else
      render json: { message: "No movies found" }
    end
  end

  def get_latest_movies
    @movies = Movie.where("is_active = true")
    if @movies
      puts "Hello sahil ...:)"
      render json: @movies
    else
      render json: { message: "No movies available" }
    end
  end

  def show
    @movie = Movie.find(params[:id])
    if @movie
      render json: @movie
    else
      render json: { message: "Movie not found" }
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.is_active = false
    if @movie.save
      render json: { message: "Movie is now in-active" }
    else
      render json: { message: "Something went wrong" }
    end
  end

  private

  def movie_params
    params.permit(:name, :genre, :release_date)
  end
end
