class AdminsController < ApplicationController
  before_action :authenticate_admin!

  def dashboard
    @users = User.paginate(page: params[:page], per_page: 10)
  end
end
