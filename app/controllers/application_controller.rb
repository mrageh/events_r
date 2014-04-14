class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user?, :current_user_admin?

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to signin_path, alert: 'You need to sign in first'
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_user?(user)
    current_user == @user
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_path
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end
end
