class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user

  def set_user_types

  end

  def set_current_user
  	if(!session[:user].nil?)
  		@current_user = User.find_by_id(session[:user]) rescue nil
  	else
  		@current_user = nil
  	end
  end

  def authenticate_user
  	if(!session[:user].nil?)
  		@current_user = User.find_by_id(session[:user])
  	else
  		redirect_to '/'
  	end
  end

  def ensure_admin
    if @current_user && @current_user.is_admin?
      true
    else
      redirect_to '/404'
    end
  end

end
