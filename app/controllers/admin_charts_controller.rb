class AdminChartsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @user = User.find_by(username: user_params[:username])

    if @user
      @images = if user_params[:content_type].present?
                  @user.images.uploads_before_day_and_by_content_type(user_params[:upload_date], user_params[:content_type])
                elsif (user_params[:file_size_min] && user_params[:file_size_max]).present?
                  @user.images.uploads_size_between(user_params[:file_size_min], user_params[:file_size_max])
                else
                  @user.images.uploads_before_day(user_params[:upload_date])
                end
    end

    @images ||= []
  end

  def new
  end

  private
    def user_params
      params.require(:user).permit(:username, :upload_date, :content_type, :file_size_min, :file_size_max)
    end
end
