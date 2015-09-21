class IdeasController < ApplicationController
  before_action :load_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:show, :edit, :update, :destroy]

  def new
    if current_user
      @idea = Idea.new(user_id: current_user.id)
      @categories = Category.all
      @images = Image.all
    else
      render plain: "Must be logged in to add an idea."
    end
  end

  def create
    image_ids = params.group_by{|k,v| v}["1"].map{|image_id, trash_value| image_id}
    idea = Idea.create(idea_params)
    idea.images << Image.where(id: image_ids)
    flash.notice = "New idea added!"
    redirect_to profile_path
  end

  def show
    @images = @idea.images
  end

  def edit
    @categories = Category.all
    @images = Image.all
  end

  def update
    if @idea.update(idea_params)
      image_ids = params.group_by{|k,v| v}["1"].map{|image_id, trash_value| image_id}
      @idea.images << Image.where(id: image_ids)
      flash.notice = "Idea updated!"
      redirect_to profile_path
    else
      flash.now[:alert] = "Failed to update!"
      render :edit
    end
  end

  def destroy
    idea_images = IdeaImage.where(idea_id: @idea.id)
    if idea_images.count > 0
      idea_images.each do |idea_image|
        idea_image.delete
      end
    end

    @idea.delete
    flash.notice = "Idea deleted!"
    redirect_to profile_path
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :description, :user_id, :category_id)
  end

  def load_idea
    @idea = Idea.find(params[:id])
  end

  def authorize
    if @idea.user != current_user
      render plain: "You're not authorized to do that (maybe you're not even logged in)."
    end
  end

end
