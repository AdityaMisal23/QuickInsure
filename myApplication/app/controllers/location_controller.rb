class LocationController < ApplicationController
  def index
    @locations = Location.all
    render json: @locations
  end

  def create
    @location = Location.new(name: params[:name])
    if @location
      render json: { message: "Location Added" }
    else
      render json: { message: "Failed" }
    end
  end
end
