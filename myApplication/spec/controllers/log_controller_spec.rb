require "rails_helper"

# get_logs_of_user

RSpec.describe LogController, type: :controller do
  before(:each) do
    @users = create_list(:user, 10)
  end

  after(:each) do
    @users.each(&:destroy)
  end

  describe "GET#inddx" do
    it "returns all logs" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET#get_logs_of_user" do
    it "returns all logs of a user" do
      get :get_logs_of_user, params: { user_id: @users[0].id }
      response.body
      expect(response).to be_successful
    end
  end
end
