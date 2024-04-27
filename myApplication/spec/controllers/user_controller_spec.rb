require "rails_helper"

RSpec.describe UserController, type: :controller do
  before(:each) do
    @user = create(:user)
  end

  after(:each) do
    @user.destroy
  end

  describe "GET#index" do
    it "returns success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST#login" do
    let(:params) do
      {
        user: {
          email: "a.m@gmail.com",
          password: "Aditya@123",
        },
      }
    end

    it "returns a unprocessable entity response" do
      print @user.name + " " + @user.email + " " + @user.password
      post :login, params: params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET#show" do
    it "shows user details" do
      puts @user
      get :show, params: { id: @user.id }
      expect(response).to be_successful
    end

    it "gives error" do
      puts @user
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "PUT#update" do
    it "updates user password" do
      puts @user
      put :update, params: { id: @user.id, password: (Faker::Name.name).capitalize + "@12345" }
      expect(response).to be_successful
    end

    it "returns a validation error" do
      puts @user
      put :update, params: { id: @user.id, password: "" }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST#create" do
    let(:params) do
      {
        name: "Aditya",
        email: "a.m@gmail.com",
        password: "Aditya@123",
        role: "admin",

      }
    end

    it "creates a user" do
      post :create, params: params
      puts(response.body)
      expect(response).to be_successful
    end
  end

  describe "DELETE#destroy" do
    it "deletes a user" do
      delete :destroy, params: { id: @user.id }
      expect(response).to be_successful
    end
  end
end
