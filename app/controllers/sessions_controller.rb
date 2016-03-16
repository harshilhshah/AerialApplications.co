class SessionsController < ApplicationController

  def login
  end

  def login_attempt
  	authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      redirect_to('/')
      session[:user] = authorized_user.id
    else
      flash.now[:notice] = "Invalid Username or Password"
      flash[:color]= "red"
      render "login"	
    end
  end

  def logout
  	session[:user] = nil
  	redirect_to('/')
  end
end
