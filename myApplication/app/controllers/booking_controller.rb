class BookingController < ApplicationController
  def index
    @bookings = Booking.all
    render json: @bookings
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      @show = Show.find(params[:show_id])
      @show.booked_tickets += 1
      render json: { message: "Booking saved" }
    else
      render json: { message: "Failed" }
    end
  end

  def get_bookings
    @bookings = Booking.find_by(user_id: params[:user_id])
    render json: @bookings
  end

  def cancel_bookings
  end

  def booking_params
    params.permit(:user_id, :show_id, :seats)
  end
end
