require "rails_helper"

RSpec.describe TheaterController, type: :controller do
  describe "GET#index" do
    it "returns a success response" do
      theater1 = create(:theater)
      get :index
      expect(response).to be_successful
    end
  end
end
