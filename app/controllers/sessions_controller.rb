class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash.notice = "You're now logged in, #{user.username.capitalize}!"
      redirect_to profile_path
    else
      flash.now[:alert] = "Login failed. Y U no know credentials?"
      render :new
    end
  end

  def destroy
    session.clear
    flash.notice = "You done logged out!"
    redirect_to root_path
  end

end
