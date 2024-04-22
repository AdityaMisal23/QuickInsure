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
      if seat.include?([params[:row].to_i, params[:col].to_i])
        render json: { message: "Seat is not available" }
        return
      end
    end

    render json: { message: "Seat is available" }
  end

  def show
    @show = Show.find(params[:id])
    if @show
      render json: @show
    else
      render json: { message: "show not found" }
    end
  end

  def get_shows_of_movie
    @shows = Theater.joins(screens: { shows: :movie })
      .where("theaters.id = ? AND shows.movie_id = ? AND shows.show_time >= ?", params[:theater_id], params[:movie_id], Time.current)
      .pluck("shows.id, shows.movie_id, shows.screen_id, shows.show_time, shows.ticket_price_ordinary, shows.ticket_price_premium")

    if @shows
      render json: @shows
    else
      render josn: { message: "No show available" }
    end
  end

  def show_seat_price
    @show = Show.find(params[:show_id])
    @screen = Screen.find(@show.screen_id)
    percentage = @screen.ordinary_percentage
    total_seat = @screen.number_of_seats
    seats_per_column = @screen.number_of_seats_per_column
    rows = total_seat / seats_per_column
    ordinary_seats = (rows * percentage) / 100
    show_ordinary_price = ((rows - ordinary_seats).to_i + ("A".ord)).chr + " to " + (rows + "A".ord).chr + " => " + (@show.ticket_price_ordinary).to_s
    show_premium_price = ("A" + " to " + ((rows - ordinary_seats - 1).to_i + 65).chr) + " => " + @show.ticket_price_premium.to_s
    render json: { premium: show_premium_price, ordinary: show_ordinary_price }
  end

  def create
    d = Date.parse(params[:date])
    t = Time.parse(params[:time])
    show_datetime = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    @show_time = show_datetime

    # @show_time = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    @screen_id = params[:screen_id]
    @movie_id = params[:movie_id]
    @ticket_price_ordinary = params[:price1]
    @ticket_price_premium = params[:price2]

    @show = Show.new(screen_id: @screen_id, movie_id: @movie_id, show_time: @show_time, ticket_price_ordinary: @ticket_price_ordinary, ticket_price_premium: @ticket_price_premium, booked_tickets: 0)

    if @show.save
      render json: @show
    else
      render json: { message: "Failed" }
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
