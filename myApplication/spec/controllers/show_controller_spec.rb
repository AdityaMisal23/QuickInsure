require "rails_helper"

RSpec.describe ShowController, type: :controller do
  before(:each) do
    @user = create(:user)
    @theater = create(:theater, user: @user)
    @screen = create(:screen, theater: @theater)
    @movie = create(:movie)
    @show = create(:show, screen: @screen, movie: @movie)
    @shows = create_list(:show, 10, screen: @screen, movie: @movie)

    create_list(:seat_with_screen, 100, resource: @screen)
    create_list(:seat_with_show, 100, resource: @show)
  end

  after(:each) do
    @shows.each(&:destroy)
    @movie.destroy
    @screen.destroy
    @theater.destroy
    @user.destroy
  end

  describe "GET#index" do
    it "returns all shows" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET#show" do
    it "returns details of specific show" do
      get :show, params: { id: @shows[3].id }
    end
  end

  describe "POST#create" do
    it "creates a new show" do
      post :create, params: { screen_id: @screen.id, movie_id: @movie.id, booked_tickets: 0, date: "2024-05-23", time: "12:00:00", gold: rand(300..400), silver: rand(200..300), platinum: rand(400..500) }
      expect(response).to be_successful
    end
  end

  describe "PUT#update" do
    it "updates ticket prices" do
      put :update, params: { id: @show.id, gold: 400, silver: 100, platinum: 1000 }
      expect(response).to be_successful
    end
  end

  describe "GET#get_all_bookings" do
    it "returns all bookings for a show" do
      get :get_all_bookings, params: { show_id: @show.id }
      expect(response).to be_successful
    end
  end

  describe "GET#get_shows_of_movie" do
    it "return shows of movie" do
      get :get_shows_of_movie, params: { theater_id: @theater.id, movie_id: @movie.id }
      expect(response).to be_successful
    end
  end

  describe "GET#get_shows_of_sreen_And_Date" do
    it "returns all shows of a particular date of screen" do
      get :get_shows_of_sreen_And_Date, params: { date: @show.show_time, screen_id: @show.screen_id }
      expect(response).to be_successful
    end
  end

  describe "Get#show_seat_price" do
    it "returns particular seat price" do
      get :show_seat_price, params: { show_id: @show.id, row: "A" }
      expect(response).to be_successful
    end
  end
end
