require "json"

class TheaterController < ApplicationController
  # def index
  #   @theater_owners = User.find_by(role: "theater")
  #   render json: @theater_owners
  # end

  def index
    @theaters = Theater.all
    if @theaters
      render json: @theaters
    else
      render json: { error: "Something went wrong" }, status: unprocessable_entity
    end
  end

  def get_theater_on_location_and_movie
    @theaters = Theater.select("theaters.id, theaters.theater_name")
      .joins(screens: { shows: :movie })
      .where("movies.id = ? AND theaters.is_active = true AND theaters.location_id= ?", params[:movie_id], params[:location_id].to_i).uniq.as_json

    render json: @theaters.as_json
  end

  def get_user_theaters
    @theaters = Theater.where("user_id = ? AND is_active = true", params[:user_id])

    if @theaters
      render json: @theaters
    else
      render json: { message: "This user have no theaters" }
    end
  end

  def destroy
    @theater = Theater.find(params[:id])
    @theater.is_active = false
    if @theater.save
      render json: { message: "Theater removed" }
    else
      render json: { message: "Failed" }
    end
  end

  def show
    @theater = Theater.find(params[:id])
    render json: @theater
  end

  def create
    # puts params[:user_id] + params[:theater_name] + params[:address] + params[:pincode]

    @theater = Theater.new(theater_params)
    if @theater.save
      @screen_data = params[:screen_data]
      @screen_data.each do |screen|
        Screen.create(name: screen[0], theater_id: @theater.id, number_of_seats: screen[1], number_of_seats_per_column: screen[2], ordinary_percentage: screen[3])
      end

      render json: { message: "new theater added" }
    else
      render json: @theater.errors.messages
    end
  end

  private

  def theater_params
    params.permit(:user_id, :theater_name, :theater_address, :pincode, :location_id)
  end
end
