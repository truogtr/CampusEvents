class UsersController < ApplicationController

  # this uses views/layouts.application.html.erb which links the asset folder
  # we should probably contain this so that we have differnet user and an event layouts.
	layout :resolve_layout

	before_action :confirm_logged_in, :except => [:new, :create]

  # All is pretty much the same as Excercise Files
  def index
    #@user = User.find(session[:user_id])
  end

  def show
    @user = User.find(params[:id])
    Rails.logger.debug("!!! #{@user}")
    # @events = @user.events
		# NOTE: use true to not get deleted events!
		# TODO is 'true' needed here?
    @event_commitments = @user.event_commitments(true)
    if @user.id == session[:user_id]
      @event_commitments = @user.event_commitments(true)  # TODO check functionality and colors
    else
      @event_commitments = @user.event_commitments(true)
			@event_commitments = @event_commitments.where(:description => "attend")
    end
  end

	def myevents
		@user = User.find(session[:user_id])

		Rails.logger.debug("!!!! session user.id: #{@user.id}")
		@filtered = Event.where(:creator_id => @user.id)
										 .order(start_time: :asc)
										 .paginate(:page => params[:page])
	end

  def new
  	@user = User.new

    #respond_to do |format|
     # format.html { render :layout => 'access' }
    #end
  end

  def create
    @user = User.new(user_params)
    @user.do_val = true
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

     # find user
     @user = User.find(session[:user_id])
     # don't skil password validation (default). This sets the variable in the model
     @user.do_val = true

     # get the subaction (whether info, pic, or password is being updated)
     subaction = params[:subaction]

     #conditional for updating based on subaction
     #skip password validation for info and pic
     if subaction == 'info'
      @user.do_val = false

      if @user.update_attributes(user_info)
        redirect_to user_path(@user)
      else
        render('edit')
      end

    elsif subaction == 'picture'
       @user.do_val = false
      if @user.update_attributes(user_pic)
         redirect_to user_path(@user)
      else
        render('edit')
      end
    elsif subaction == 'pass'
      if @user.update_attributes(user_pass)
         redirect_to user_path(@user)
      else
        render('edit')
      end
    end

  end

  def delete
  end

  def destroy
    session[:user_id] = nil
    session[:email] = nil
    @user = User.find(params[:id])
		# NOTE: use destroy, not delete! Destroy invokes destruction of associated
		# event_commitments, by the dependent => destroy in the User model.
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,
      :email, :password, :password_confirmation, :year, :major, :avatar, :bio)
  end

  def user_info
    params.require(:user).permit(:first_name, :last_name, :major, :year)
  end

  def user_pic
    params.require(:user).permit(:avatar)
  end

  def user_pass
    params.require(:user).permit(:password, :password_confirmation)
  end


  def resolve_layout
    case action_name
    when "new", "create"
      "access"
    else
      "application"
    end
  end

end


=begin
@user.update_attribute(:first_name, params[:user][:first_name]) and
        @user.update_attribute(:last_name, params[:user][:last_name]) and
        @user.update_attribute(:major, params[:user][:major]) and
        @user.update_attribute(:year, params[:user][:year])


              # user_params2.reject{|k,v| v.blank?}))
        #,
       #:last_name => params[:user][:last_name], :major => params[:user][:major],
        #:year => params[:user][:year] )
       # params.require(:user).permit(:first_name, :last_name, :year, :major) )

         #params[:user] = nil if params[:user].blank?

      #params[:user][:password]=  nil;
      # Rails.logger.debug "!!! #{params[:user][:password].blank?} !!!"
       #params[:user].delete(:password)
       #params[:user].delete(:password_confirmation)

=end

=begin
    if @user.update_attributes(user_params)
      Rails.logger.debug "!!! WORKED !!!"
      redirect_to user_path(@user)
    else
      render('edit')
       Rails.logger.debug(" USER ERRROR MESSSGESS #{@user.errors.full_messages}")
      Rails.logger.info(@user.errors.inspect)
    end
=end
