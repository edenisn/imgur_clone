class UserChartsController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_params[:upload_date]
      day = Date.parse(user_params[:upload_date])
      @images = current_user.images.where("created_at >= ? AND created_at <= ?",
                                          day.beginning_of_day, day.end_of_day)
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
