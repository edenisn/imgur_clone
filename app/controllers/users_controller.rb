class UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_dashboard_path, notice: 'User was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_dashboard_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def find_user
      @user = User.find(params[:id])
    end
end
