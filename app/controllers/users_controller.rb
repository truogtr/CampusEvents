class UsersController < ApplicationController
  
  # this uses views/layouts.application.html.erb which links the asset folder
  # we should probably contain this so that we have differnt user and an event layouts.
	layout 'application'

	before_action :confirm_logged_in, :except => [:new, :create]

  # All is pretty much the same as Excercise Files
  def index
    #@user = User.find(session[:user_id])
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'Account created.'
      redirect_to user_path(@user)
    else
      render("new")
    end
  end

  def edit

    @user = User.find(session[:user_id])

  end

    def update


     Rails.logger.debug "!!! #{params.inspect} !!!"
     
     @user = User.find(session[:user_id])

    if @user.update_attribute(:avatar, params[:user][:avatar])
      Rails.logger.debug "!!! WORKED !!!"
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user)
       Rails.logger.debug(" USER ERRROR MESSSGESS #{@user.errors.inspect}")
      Rails.logger.info(@user.errors.inspect)
    end
  end

  def delete
  end

  def destroy
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name,
      :email, :password)
  end




end





