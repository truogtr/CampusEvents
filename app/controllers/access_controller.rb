class AccessController < ApplicationController


	layout 'application'
	def login
		#login form
	end

def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      flash[:notice] = "You are now logged in."
      redirect_to user_path(session[:user_id])
    else
      flash[:notice] = "Invalid email/password combination."
      redirect_to root_path
    end
  end

  def logout
    # mark user as logged out
    session[:user_id] = nil
    session[:email] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

end
