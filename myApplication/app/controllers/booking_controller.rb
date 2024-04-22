class BookingController < ApplicationController
  def index
    @bookings = Booking.all
    render json: @bookings
  end

  #send raw data
  def create
    user_id = params[:user_id]
    show_id = params[:show_id]
    seats = params[:seats]
    @booking = Booking.new(user_id: user_id, show_id: show_id, seats: [])

    seats.each { |seat| @booking.seats.push(seat) }

    if @booking.save
      @show = Show.find(params[:show_id])
      @show.booked_tickets += seats.length
      render json: { message: "Booking saved" }
    else
      render json: { message: "Failed" }
    end
  end

  def show
    @booking = Booking.where("id = ?", params[:id])
    if @booking.size > 0
      render json: @booking
    else
      render json: { message: "show not found" }
    end
  end

  def get_bookings
    @bookings = Booking.where("user_id = ? ", params[:user_id])
    render json: @bookings
  end

  def cancel_bookings
  end
end
