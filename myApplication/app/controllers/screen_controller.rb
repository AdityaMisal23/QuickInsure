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

  def get_theater_screens_of_movie
    @screens = Theater.joins(screens: { shows: :movie })
      .where("theaters.id = ? AND movies.id = ? AND shows.show_time >= ?", params[:theater_id], params[:movie_id], DateTime.now)
      .pluck("screens.name,screens.id").as_json
    if @screens.present?
      render json: @screens
    else
      render json: { message: "No screen present" }
    end
  end

  def show
    @screen = Screen.find(params[:id])
    render json: @screen
  end

  def destroy
    @screen = Screen.where(id: params[:id])
    if @screen.present?
      @screen[0].is_active = false
      @screen[0].save
      render json: { message: "Screen is removed" }
    else
      render json: { message: "Screen is not present" }
    end
  end

  def create
    @name = params[:name]
    @theater_id = params[:theater_id].to_i
    @number_of_seats = params[:number_of_seats].to_i

    @screen = Screen.new(name: @name, theater_id: @theater_id, number_of_seats: @number_of_seats)
    @screen.save

    @seats = params[:seats]
    @seats.each do |seat|
      row = seat["row"]
      total_seat = seat["total"].to_i
      type = seat["type"]
      resource_type = "Screen"

      for i in 1..total_seat
        @seat = Seat.new(resource_id: @screen.id, resource_type: resource_type, row: row, column: i, section: type)
        @seat.save
      end
    end
    render json: { message: "Screen added" }
  end
end
