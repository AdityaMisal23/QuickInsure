require "rails_helper"

RSpec.describe MovieController, type: :controller do
  before(:each) do
    @movie = create(:movie)
    @movies = create_list(:movie, 10)
  end

  after(:each) do
    @movie.destroy
    @movies.destroy
  end

  describe "GET#index" do
    it "returns all movies" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST#create" do
    it "creates a movie" do
      post :create, params: FactoryBot.attributes_for(:movie)
      expect(response).to be_successful
    end
  end

  describe "GET#find_movie_using_genre" do
    it "returns movies based on genre" do
      get :find_movie_using_genre, params: { genre: "action" }
      expect(response).to be_successful
    end
  end

  describe "GET#show" do
    it "returns specific movie details" do
      get :show, params: { id: @movie.id }
      expect(response).to be_successful
    end
  end

  describe "DELETE#destroy" do
    it "deletes a movie" do
      delete :destroy, params: { id: @movie.id }
      expect(response).to be_successful
    end
  end

  describe "GET#search_a_movie" do
    it "searches a movie" do
      get :search_a_movie, params: { name: @movies[1].name }
      expect(response).to be_successful
    end
  end

  describe "GET#get_latest_movies" do
    it "return latest and top movies based on bookings" do
      screen = create(:screen)
      create_list(:seat, 80, resource: screen)
      movie1 = create(:movie)
      movie2 = create(:movie)
      show1 = create(:show, screen: screen, movie: movie1)
      show2 = create(:show, screen: screen, movie: movie2)
      create_list(:seat, 50, resource: show1)
      create_list(:seat, 100, resource: show2)

      get :get_latest_movies
      expect(response).to be_successful
    end
  end
end
