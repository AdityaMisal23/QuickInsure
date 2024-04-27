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
    @screens = Screen.find_by(theater_id: params[:id])
    if @screens.present?
      @screens.each do |screen|
        screen.is_active = false
        screen.save
      end
    end
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
    theater = Theater.new(theater_params)
    if theater.save
      render json: { message: "Theater added" }
    else
      render json: { message: "Failed" }
    end
  end

  private

  def theater_params
    params.permit(:user_id, :theater_name, :theater_address, :pincode, :location_id)
  end
end
