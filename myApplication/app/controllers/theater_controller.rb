require "json"

class TheaterController < ApplicationController
  # def index
  #   @theater_owners = User.find_by(role: "theater")
  #   render json: @theater_owners
  # end

  def index
    @theaters = Theater.select("theaters.id, theaters.theater_name")
      .joins(screens: { shows: :movie })
      .where("movies.name = ? AND theaters.location_id= ?", params[:movie_name], params[:location_id]).as_json

    render json: @theaters.as_json
  end

  def destroy
    @theater = Theater.find(params[:id])
    @theater.active = false
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
      @screen_data.each do |screen_params|
        screen_hash = screen_params.permit!.to_h
        screen, seats = screen_hash.first
        Screen.create(name: screen, theater_id: @theater.id, number_of_seats: seats)
      end

      render json: { message: "new theater added" }
    else
      render json: @theater.errors.messages
    end
  end

  private

  def theater_params
    params.permit(:user_id, :theater_name, :theater_address, :pincode, :location_id, :active)
  end
end
