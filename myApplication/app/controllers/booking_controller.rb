class BookingController < ApplicationController
  def index
    @bookings = Booking.joins(show: { screen: :theater })
                   .joins("INNER JOIN seats ON seats.resource_id = shows.id")
                   .joins("INNER JOIN movies ON shows.movie_id = movies.id")
                   .where("seats.resource_type = ?", "Show")
                   .order("bookings.created_at DESC")
                   .pluck("bookings.id, bookings.user_id, theaters.id, theaters.theater_name, theaters.theater_address, shows.show_time, shows.screen_id, movies.name, seats.row, seats.column, seats.section")

    grouped_seats = @bookings.group_by { |booking| booking[0] }

    @bookings = grouped_seats.map do |booking_id, bookings|
      {
        booking_id: booking_id,
        user_id: bookings.first[1],
        theater_id: bookings.first[2],
        theater_name: bookings.first[3],
        theater_address: bookings.first[4],
        show_timing: bookings.first[5],
        screen_id: bookings.first[6],
        movie_name: bookings.first[7],
        seats: bookings.map { |booking| "#{booking[8]}#{booking[9]}" },
        seat_section: bookings.first[10]
      }
    end

    if @bookings.present?
      render json: @bookings
    else
      render json: {message: "No bookings present"}
    end
  end

  #send raw data
  def create
    user_id = params[:user_id]
    show_id = params[:show_id]
    seats = params[:seats]
    @booking = Booking.new(user_id: user_id, show_id: show_id, seats: [])

    seats.each do |seat|
      seat = Seat.new(resource_id: show_id, resource_type: "Show", row: seat["row"], column: seat["column"], section: seat["type"])
      seat.save
      @booking.seats.push(seat.id)
    end

    if @booking.save
      @show = Show.find(params[:show_id])
      @show.booked_tickets += seats.size
      @show.save
      render json: { message: "Booking saved" }
    else
      render json: { message: "Failed" }
    end
  end

  def show
    @bookings =  Booking.joins(show: { screen: :theater })
                .joins("INNER JOIN seats ON seats.resource_id = shows.id")
                .joins("INNER JOIN movies ON shows.movie_id = movies.id")
                .where("seats.resource_type = ? AND bookings.id = ?", "Show", params[:id])
                .order("bookings.created_at DESC")
                .pluck("bookings.id, bookings.user_id, theaters.id, theaters.theater_name, theaters.theater_address, shows.show_time, shows.screen_id, movies.name, seats.row, seats.column, seats.section")


    grouped_seats = @bookings.group_by { |booking| booking[0] }

    @bookings = grouped_seats.map do |booking_id, bookings|
      {
        booking_id: booking_id,
        user_id: bookings.first[1],
        theater_id: bookings.first[2],
        theater_name: bookings.first[3],
        theater_address: bookings.first[4],
        show_timing: bookings.first[5],
        screen_id: bookings.first[6],
        movie_name: bookings.first[7],
        seats: bookings.map { |booking| "#{booking[8]}#{booking[9]}" },
        seat_section: bookings.first[10]
      }
    end


    if @bookings.present?
      render json: @bookings
    else
      render json: {message: "No bookings present"}
    end
  end

  def get_bookings

    @bookings = Booking.joins(show: { screen: :theater })
                .joins("INNER JOIN seats ON seats.resource_id = shows.id")
                .joins("INNER JOIN movies ON shows.movie_id = movies.id")
                .where("seats.resource_type = ? AND bookings.user_id = ?" , "Show", params[:user_id])
                .order("bookings.created_at DESC")
                .pluck("bookings.id, bookings.user_id, theaters.id, theaters.theater_name, theaters.theater_address, shows.show_time, shows.screen_id, movies.name, seats.row, seats.column, seats.section")


    grouped_seats = @bookings.group_by { |booking| booking[0] }

    @bookings = grouped_seats.map do |booking_id, bookings|
      {
        booking_id: booking_id,
        user_id: bookings.first[1],
        theater_id: bookings.first[2],
        theater_name: bookings.first[3],
        theater_address: bookings.first[4],
        show_timing: bookings.first[5],
        screen_id: bookings.first[6],
        movie_name: bookings.first[7],
        seats: bookings.map { |booking| "#{booking[8]}#{booking[9]}" },
        seat_section: bookings.first[10]
      }
    end

    if @bookings.present?
      render json: @bookings
    else
      render json: {message: "No bookings present"}
    end
  end

  def cancel_bookings
  end
end
