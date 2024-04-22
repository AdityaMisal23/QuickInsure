class ScreenController < ApplicationController
  def index
    @screens = Screen.all
    if @screens
      render json: @screens
    else
      render json: { message: "Something went wrong" }
    end
  end

  def get_theater_screens
    @screens = Screen.where("theater_id =  ?", params[:theater_id])

    if @screens
      print @screens
      render json: @screens.as_json
    else
      render json: { message: "No screens found" }
    end
  end

  def is_premium
    @seat = params[:seat]
    @show = Show.where("id = ?", params[:show_id])
    if ((@show.number_of_seats * @show.ordinary_percentage) / 100) > params[:row]
      render json: true
      return
    end
    render json: false
  end

  def get_theater_screens_of_movie
    @screens = Theater.joins(screens: { shows: :movie })
      .where("theaters.id = ? AND movies.id = ? AND shows.show_time = ?", params[:theater_id], params[:movie_id], Time.current)
      .pluck("screens.name,screens.id").as_json
  end

  def show
    @screen = Screen.find(params[:id])
    render json: @screen
  end

  def create
    @screen = Screen.new(screen_params)
    if @screen.save!
      render json: { message: "Screen added" }
    else
      render json: { message: "Failed" }
    end
  end

  def destroy
    @screen = Screen.find(params[:id])
    @screen.is_active = false
    @screen.save
  end

  private

  def screen_params
    params.permit(:name, :theater_id, :number_of_seats, :ordinary_percentage)
  end
end
