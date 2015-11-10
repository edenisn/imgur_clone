class UserChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_params[:upload_date]
      @images = current_user.images.upload_images_by_hour_of_day(Date.parse(user_params[:upload_date]))
    end

    @images ||= []
  end

  def new
  end

  private
    def user_params
      params.require(:user).permit(:upload_date)
    end
end
