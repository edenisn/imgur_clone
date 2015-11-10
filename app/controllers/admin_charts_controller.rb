class AdminChartsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find_by(username: user_params[:username])
    if @user
      @images = if user_params[:content_type].present?
                  @user.images.where("created_at <= ? AND content_type = ?", user_params[:upload_date], user_params[:content_type])
                elsif (user_params[:file_size_1] && user_params[:file_size_2]).present?
                  @user.images.where("file_size >= ? AND file_size <= ?", user_params[:file_size_1], user_params[:file_size_2])
                else
                  @user.images.where("created_at <= ?", user_params[:upload_date])
                end
    end

    @images ||= []
  end

  def new
  end

  private
    def user_params
      params.require(:user).permit(:username, :upload_date, :content_type, :file_size_1, :file_size_2)
    end
end
