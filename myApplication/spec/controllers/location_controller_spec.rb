require "rails_helper"

RSpec.describe LocationController, type: :controller do
  before(:each) do
    @locations = create_list(:location)
  end

  after(:each) do
    @locations.destroy
  end

  describe "GET#index" do
    let!(:location) { create(:location) }
    it "returns all locations" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST#create" do
    it "Adds new location" do
      post :create, params: FactoryBot.attributes_for(:location)
      puts response.body
      expect(response).to be_successful
    end
  end
end
