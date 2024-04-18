class ShowController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @shows = Show.all
    render json: @shows
  end

  def get_all_bookings
    @seats = Booking.where(show_id: params[:show_id]).pluck(:seats)
    if @seats.length > 0
      render json: @seats
    else
      render json: { message: "This show has no bookings" }
    end
  end

  def get_seat_availability
    @seats = Booking.where(show_id: params[:show_id]).pluck(:seats)
    @seats.each do |seat|
      # render json: seat
      # return
      if seat.include?([params[:row].to_i, params[:col].to_i])
        render json: true
        return
      end
    end

    render json: false
  end

  def show
    # get all details of a particular show
    @show = Show.find(params[:id])
    if @show
      render json: @show
    else
      render json: { message: "show not found" }
    end
  end

  def update
    @show = Show.find(params[:id])
    @show.ticket_price_ordinary = params[:ordinary_price]
    @show.ticket_price_premium = params[:premium_price]

    if @show.save
      render json: { message: "update success" }
    else
      render json: { message: "update failed" }
    end
  end
end
