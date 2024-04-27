require "rails_helper"

RSpec.describe ScreenController, type: :controller do
  before(:each) do
    @theater = create(:theater)
    @screens = create_list(:screen, 10, theater: @theater)
    @screen = create(:screen, theater: @theater)
    @movie = create(:movie)
    @shows = create(:show, screen: @screen, movie: @movie)
  end

  after(:each) do
    @screens.each(&:destroy)
    @movie.destroy
    @shows.destroy_all
    @theater.destroy
    @screen.destroy
  end

  describe "GET#index" do
    it "returns all screens" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST#create" do
    it "creates a new screen" do
      seats = [
        { "row" => "A",
          "total" => 10,
          "type" => "platinum" },
        { "row" => "B",
          "total" => 10,
          "type" => "platinum" },
        { "row" => "C",
          "total" => 10,
          "type" => "gold" },
        { "row" => "D",
          "total" => 10,
          "type" => "gold" },
      ]
      post :create, params: { screen: FactoryBot.attributes_for(:screen), seats: seats }
      expect(response).to be_successful
    end
  end

  describe "DELETE#destroy" do
    it "removes a screen" do
      delete :destroy, params: { id: @screen.id }
      expect(response).to be_successful
    end
  end

  describe "GET#show" do
    it "return details of specific screen" do
      get :show, params: { id: @screen.id }
      expect(response).to be_successful
    end
  end

  describe "GET#get_theater_screens" do
    it "return all screens of particular theater" do
      get :get_theater_screens, params: { theater_id: @theater.id }
      expect(response).to be_successful
    end
  end

  describe "GET#get_theater_screens_of_movie" do
    it "returns all screens of particular theater of particular movie" do
      get :get_theater_screens_of_movie, params: { theater_id: @theater.id, movie_id: @movie.id }
      expect(response).to be_successful
    end
  end
end
