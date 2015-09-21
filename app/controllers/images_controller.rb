class ImagesController < ApplicationController
  before_action :load_image, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  def new
    @image = Image.new
  end

  def create
    Image.create(image_params)
    redirect_to images_path
  end

  def index
    @images = Image.all
  end

  def edit
  end

  def update
    @image.update(image_params)
    flash.notice = "Image address updated!"
    redirect_to images_path
  end

  def destroy
    idea_images = IdeaImage.where(image_id: @image.id)
    if idea_images.count > 0
      idea_images.each do |idea_image|
        idea_image.delete
      end
    end

    @image.delete
    flash.notice = "Image deleted!"
    redirect_to images_path
  end

  private

    def image_params
      params.require(:image).permit(:address)
    end

    def load_image
      @image = Image.find(params[:id])
    end

    def authorize
      if !current_user.admin?
        render plain: "Only an admin can mess with images... make sure you're logged in."
      end
    end

end
