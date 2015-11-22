class UserChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_date, only: :index

  def index
    if user_params[:upload_date]
      @images = current_user.images.uploads_by_hour_of_day(Date.parse(user_params[:upload_date]))
    end

    @images ||= []
  end

  def new
  end

  private
    def user_params
      params.require(:user).permit(:upload_date)
    end

    def validate_date
      begin
        Date.parse(user_params[:upload_date])
      rescue
        flash[:notice] = "Invalid date"
        redirect_to :back
      end
    end
end
