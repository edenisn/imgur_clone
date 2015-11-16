class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create, :thumb]
  before_action :find_image, only: [:show, :edit, :update, :destroy, :thumb]

  def index
    @images = if current_user && params[:search]
                current_user.images.search(params[:search]).order("created_at DESC")
              elsif current_user
                current_user.images.all
              elsif !current_user && params[:search]
                Image.search(params[:search]).where(user_id: nil).order("created_at DESC")
              else
                Image.where(user_id: nil)
              end
  end

  def create
    if current_user
      @image = current_user.images.new(image_params)
    else
      @image = Image.new(image_params)
    end

    respond_to do |format|
      if @image.save
        format.js { render inline: "location.reload();" }
      else
        format.js
      end
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

  def thumb
    width = params[:new_size].split("x")[0].to_i
    height = params[:new_size].split("x")[1].to_i

    @img_resize = ImagePreview.image_resize(@image.attachment, width, height)
    file_path = "public/previews/#{params[:id]}_#{width}_#{height}.jpg"
    @img_resize.write(file_path)

    ImagePreview.store_to_s3(file_path)

    send_data @img_resize.to_blob, type: 'image/jpg', disposition: 'inline'
  end

  private
    def image_params
      params.require(:image).permit(:user_id, :name, :description, :attachment, :attachment_cache)
    end

    def find_image
      @image = Image.find(params[:id])
    end
end
