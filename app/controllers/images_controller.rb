class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
  before_action :find_image, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @images = current_user.images.all
    else
      @images = Image.where("user_id is NULL")
    end
  end

  def new
    @image = Image.new
  end

  def create
    if current_user
      @image = current_user.images.create(image_params)
    else
      @image = Image.create(image_params)
    end
  end

  def update
    if @image.update(image_params)
      redirect_to @image, notice: "Image successfully updated"
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @image.destroy
    redirect_to images_path
  end

  private
    def image_params
      params.require(:image).permit(:user_id, :name, :description, :attachment)
    end

    def find_image
      @image = Image.find(params[:id])
    end
end
