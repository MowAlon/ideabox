class IdeasController < ApplicationController
  before_action :load_idea, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:show, :edit, :update, :destroy]

  def new
    if current_user
      @idea = Idea.new(user_id: current_user.id)
      @categories = Category.all
    else
      render plain: "Must be logged in to add an idea."
    end
  end

  def create
    idea = Idea.create(idea_params)
    redirect_to profile_path
  end

  def show
  end

  def edit
    @categories = Category.all
  end

  def update
    if @idea.update(idea_params)
      flash.notice = "Idea updated!"
      redirect_to profile_path
    else
      flash.now[:notice] = "Failed to update!"
      render :edit
    end
  end

  def destroy
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
