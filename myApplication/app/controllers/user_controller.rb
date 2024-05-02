class UserController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:login]
  # skip_before_action :verify_authenticity_token, only: [:signup]

  # def store_user_details
  #   session[:user_id] = params[:user_id]
  #   session[:user_name] = params[:user_name]
  # end

  def index
    @all_users = User.all
    # render json: @all_users
    # render :index
  end

  def get_users_based_on_role
    @users = User.where(role: params[:role])
    if @users.present?
      render json: @users
    else
      render json: { message: "Users not present with this role" }
    end
  end

  def login
    puts params[:username]
    puts params[:password]
    puts params[:role]
    @user = User.find_by(email: params[:username], password: params[:password], role: params[:role])
    if @user
      # session[:user_id] = @user.id
      render json: { message: "Login successful" }
    else
      render json: { error: "Invalid email or password" }, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.present?
      render json: @user
    else
      render json: { message: "wrong id passed" }, status: :bad_request
    end
  end

  def update
    if params[:password] == ""
      render json: { message: "Password must exists" }, status: :unprocessable_entity
      return
    end
    @user = User.find(params[:id])
    if @user
      @user.password = params[:password]
      @user.save
      render json: { message: "Update success" }
    else
      render json: { message: "Update Failed" }, status: :unprocessable_entity
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
    @user.is_active = false

    if @user.save
      render json: { message: "user removed" }
    else
      render json: { message: "failed" }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
