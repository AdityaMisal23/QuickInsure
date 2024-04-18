class UserController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:login]
  # skip_before_action :verify_authenticity_token, only: [:signup]

  # def store_user_details
  #   session[:user_id] = params[:user_id]
  #   session[:user_name] = params[:user_name]
  # end

  def index
    @Allusers = User.all
    render json: @Allusers
  end

  def user_names
    names = User.all.pluck(:name)
    render json: names
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      # session[:user_id] = @user.id
      render json: { message: "Login successful" }
    else
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.password = params[:password]
      @user.save
      render json: { message: "Update success" }
    else
      render json: { message: "Update Failed" }
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      # @user.create_log(@user.id, @user.name) # Passing user_id and user_name
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.active = false

    if @user.save
      render json: { message: "user removed" }
    else
      render json: { message: "failed" }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role, :active)
  end
end
