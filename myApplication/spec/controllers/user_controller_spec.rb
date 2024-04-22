require "rails_helper"

RSpec.describe UserController, type: :controller do
  describe "GET#index" do
    it "returns success response" do
      create(:user)
      get :index
      expect(response).to be_successful
    end
  end
end
