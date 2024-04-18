class LogController < ApplicationController
  def index
    @logs = Log.all
    render json: @logs
  end

  def get_logs_of_user
    @logs = Log.find_by(user_id: params[:user_id])
    render json: @logs
  end
end
