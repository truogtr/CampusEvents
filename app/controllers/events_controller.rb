class EventsController < ApplicationController
  
	layout 'application'
  #respond_to :js, :json, :html

 #helper_method :attend
  def index
  	@events = Event.order(:start_time)

    
     #@events = Event.between(params['start'], params['end']) if (params['start'] && params['end']) 

   
  end

  def filter

    cat = params[:cat]


    @filtered = Event.order(:start_time)
       # Rails.logger.debug("****CALLED**** #{params[:subaction]}")

    if cat == "Social"
      @filtered = Event.where(:category => "Social")
     
    elsif cat == "Academic"
      @filtered = Event.where(:category => "Academic")
    elsif cat == "Sports and Recreation"
      @filtered = Event.where(:category => "Sports and Recreation")
       #Rails.logger.debug("****ENTERED**** #{@filtered.size}")
    elsif cat == "Arts"
      @filtered = Event.where(:category => "Arts")
    elsif cat == "Religion"
      @filtered = Event.where(:category => "Religion")
    end

    respond_to do |format|
      format.js
      format.html {  }
      #format.json { render json: {  } }
    end
  end

  def show
    #Rails.cache.clear
     #Rails.logger.debug("!! CACHE CLEARED")

  	 @event = Event.find(params[:id])
  	 @user = User.find(session[:user_id])

  end

  def new
  	@event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @creator = User.find(session[:user_id])

    @event.creator_id = @creator.id
    @event.users << @creator
    if @event.save
      flash[:notice] = 'Event created.'
      redirect_to event_path(@event.id)
    else
      render("new")
    end
  end

  def edit
  end

  def delete
  end

  def attend

    Rails.cache.clear
    Rails.logger.debug("!!!!cache clear")
 

  	@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])
   
    if @event.users.exclude?(@attendee)
      @event.users << @attendee
      @event.save

    else
      @event.users.delete(@attendee)
    end

    @attendees = @event.users


    respond_to do |format|
      format.js
      format.html { redirect_to(@event) }
    end




end


  private 

  def event_params
    params.require(:event).permit(:event_name, :location, :event_description,
      :start_time, :end_time, :category)
  end
end
