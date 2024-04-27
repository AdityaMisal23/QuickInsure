class MovieController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def search_a_movie
    @movies = Movie.where("name like ? or name = ?", "%#{(params[:name]).upcase}%", params[:name])
    if @movies.present?
      render json: @movies
    else
      render json: { message: "No such movie present" }
    end
  end

  def all_active_movies
    @movies = Movie.where("is_active = true")
    if @movies
      render json: @movies
    else
      render json: { message: "No movies available" }
    end
  end

  def get_latest_movies
    # Assuming `params` is accessible within this method
    d = 2.months.ago
    # t = Time.parse(params[:time])
    # within_date = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)

    movie_name = Movie.select("movies.id,movies.name")
      .joins(shows: { screen: :theater })
      .where(movies: { is_active: true })
      .where("release_date >= ?", d.to_s)
      .group("movies.id")
      .order("sum(shows.booked_tickets) DESC")
      .as_json

    if movie_name.length > 0
      render json: movie_name
    else
      all_active_movies
    end
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
