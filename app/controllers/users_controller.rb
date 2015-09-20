class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    redirect_to profile_path
  end

  def show
    if current_user
      @user = current_user
      @ideas = @user.ideas
    else
      render plain: "You're not logged in. Please login to view your account info."
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
