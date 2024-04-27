class ShowController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @shows = Show.all
    render json: @shows
  end

  def get_all_bookings
    @seats = Seat.where("resource_type = ? AND resource_id = ?", "Show", params[:show_id]).as_json
    if @seats.length > 0
      render json: { seat_bookings: @seats.as_json }
    else
      render json: { message: "This show has no bookings" }
    end
  end

  def get_seat_availability
    @seat = Seat.find_by(resource_type: "Show", resource_id: params[:show_id], row: params[:row], column: params[:column].to_i)
    if @seat.present?
      render json: { message: "seat is not available" }
    else
      render json: { message: "seat is available" }
    end
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
    @show_data = Theater.joins(screens: { shows: :movie })
      .where("theaters.id = ? AND shows.movie_id = ? AND shows.show_time >= ? AND screens.is_active = true", params[:theater_id].to_i, params[:movie_id].to_i, Time.now)
      .pluck("shows.id, shows.movie_id, shows.screen_id, shows.show_time, shows.gold, shows.silver, shows.platinum")
      .map do |show|
      {
        id: show[0],
        movie_id: show[1],
        screen_id: show[2],
        show_time: show[3],
        gold: show[4],
        silver: show[5],
        platinum: show[6],
      }
    end

    if @show_data.present?
      render json: @show_data.as_json
    else
      render josn: { message: "No show available" }
    end
  end

  def check_slot_available
    d = Date.parse(params[:date])
    t = Time.parse(params[:time])
    show_datetime = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    @show_time = show_datetime

    @show = Show.find_by(screen_id: params[:screen_id], show_time: show_datetime)

    if @show.present?
      render json: { message: "slot is occupied" }
    else
      render json: { message: "slot is free" }
    end
  end

  def show_seat_price
    @show = Show.find(params[:show_id].to_i)
    @section = Seat.select("section").find_by(resource_type: "Screen", resource_id: @show.screen_id, row: params[:row], column: 1)
    if @section
      price = Show.where(id: params[:show_id]).pluck(@section.section).as_json
      render json: { price: price[0].to_i }
    else
      render json: { message: "Invalid row" }
    end
  end

  def create
    d = Date.parse(params[:date])
    t = Time.parse(params[:time])
    show_datetime = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    @show_time = show_datetime

    # @show_time = DateTime.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    @screen_id = params[:screen_id]
    @movie_id = params[:movie_id]
    @gold = params[:gold]
    @silver = params[:silver]
    @platinum = params[:platinum]

    @show = Show.new(screen_id: @screen_id, movie_id: @movie_id, show_time: @show_time, booked_tickets: 0, gold: @gold, platinum: @platinum, silver: @silver)

    if @show.save
      render json: @show
    else
      render json: { message: @show.errors.messages }
    end
  end

  def get_shows_of_sreen_And_Date
    @date = Date.parse(params[:date])
    @show = Show.joins(:movie)
      .where("DATE(shows.show_time) = ? AND shows.screen_id = ?", @date, params[:screen_id])
      .pluck("shows.id, shows.show_time AS show_date, movies.movie_duration")
      .map do |sh|
      {
        show_id: sh[0],
        show_time: sh[1],
        show_duration: (sh[2].to_i).to_s + " mins",
      }
    end

    if @show.present?
      render json: @show
    else
      render json: { message: "There are no shows present on this date" }
    end
  end

  def update
    @show = Show.find(params[:id])
    if @show.present?
      @show.gold = params[:gold]
      @show.silver = params[:silver]
      @show.platinum = params[:platinum]
    else
      render json: { message: "Show with given id not found" }
      return
    end

    if @show.save
      render json: { message: "update success" }
    else
      render json: { message: "update failed" }
    end
  end
end
