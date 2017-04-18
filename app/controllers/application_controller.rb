class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    @user = current_user
    @user_list = User.all.pluck(:name).unshift("")
  end
end
