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
    @movies = Movi.find_by(genre: params[:genre])
    render json: @movies
  end

  private

  def movie_params
    params.permit(:name, :genre, :release_date)
  end
end
