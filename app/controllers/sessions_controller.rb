class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    if user = Session.new(params[:session]).user 
      redirect_to user_path(user), notice: "Welcome back, #{user.name}!"
    else
      redirect_to signin_path, notice: 'Invalid Email/Password combination' 
    end
  end
end
