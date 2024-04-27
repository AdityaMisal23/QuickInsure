require "rails_helper"

RSpec.describe TheaterController, type: :controller do
  before(:each) do
    @user = create(:user)
    @theater = create(:theater)
    @theaters = create_list(:theater, 10, user: @user)
  end

  after(:each) do
    @user.destroy
    @theater.destroy
    @theaters.each(&:destroy)
  end

  describe "GET#index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST#create" do
    context "with invalid parameters" do
      let(:invalid_params) do
        {
          theater: {
            theater_name: "",
            theater_address: "123 Example St",
            pincode: "122",
            location_id: 1,
          },
        }
      end

      it "does not create a new theater" do
        expect {
          post :create, params: invalid_params
        }.to_not change(Theater, :count)
      end
    end

    context "with valid parameters" do
      let(:valid_params) do
        {
          theater: {
            theater_name: "abc",
            theater_address: "xxxscx , pune",
            pincode: "123456",
            location_id: 1,
          },
        }
      end

      it "returns a successful response" do
        post :create, params: valid_params
        expect(response).to be_successful
      end
    end
  end

  describe "GET#get_theater_on_location_and_movie" do
    it "return theaters based on location and movie" do
      location = create(:location)
      @screen = create(:screen, theater: @theater)
      @movie = create(:movie)
      @shows = create_list(:show, 10, screen: @screen, movie: @movie)
      get :get_theater_on_location_and_movie, params: { location_id: location.id, movie_id: @movie.id }
      expect(response).to be_successful
    end
  end

  describe "GET#get_user_theaters" do
    it "return user specific theaters" do
      get :get_user_theaters, params: { user_id: @user.id }
      puts response.body
      expect(response).to be_successful
    end
  end

  describe "GET#show" do
    it "returns specific theater details" do
      get :show, params: { id: @theater.id }
      expect(response).to be_successful
    end
  end

  describe "DELETE#destroy" do
    it "deletes specific theater" do
      delete :destroy, params: { id: @theater.id }
      expect(response).to be_successful
    end
  end
end
