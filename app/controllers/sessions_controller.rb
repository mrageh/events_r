class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    if user = Session.new(params[:session]).user 
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back, #{user.name}!"
    else
      redirect_to signin_path, notice: 'Invalid Email/Password combination' 
    end
  end
end
