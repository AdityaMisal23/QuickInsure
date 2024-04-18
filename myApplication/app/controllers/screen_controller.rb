class ScreenController < ApplicationController
  def index
    @screens = Theater.joins(screens: { shows: :movie })
      .where("movies.name = ? AND theaters.location_id= ? AND theaters.id = ?", params[:movie_name], params[:location], params[:theater_id]).pluck("screens.id, screens.name").as_json

    if @screens
      print @screens
      render json: @screens.as_json
    else
      render json: { message: "No screens found" }
    end
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
    @screen.active = false
    @screen.save
  end

  private

  def screen_params
    params.permit(:name, :theater_id, :number_of_seats)
  end
end
