class ImagesController < ApplicationController
  before_action :find_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = current_user.images.all
  end

  def new
    @image = Image.new
  end

  def create
    if current_user
      @image = current_user.images.new(image_params)
    else
      @image = Image.new(image_params)
    end

    if @image.save
      redirect_to @image, notice: "Image successfully created"
    else
      render 'new'
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
