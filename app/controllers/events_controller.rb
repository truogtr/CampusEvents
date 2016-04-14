class EventsController < ApplicationController

  # this uses views/layouts.application.html.erb which links the asset folder
  # we should probably contain this so that we have differnt user and an event layouts.
	layout 'application'


  # get events ordered by start time for index page
  def index
  	@events = Event.order(:start_time)
    # TODO filter here (or with javascript on page?, no, better here, once
    # there's a lot of data) to only get the ones with end_time after right
    # now.

     #@events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])

  end

  # filter events on index page
  def filter

    # grabs name of button to sort by category
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

    # respond to: calls filter.js.erb
    respond_to do |format|
      format.js
      format.html {  }
      #format.json { render json: {  } }
    end
  end

  # display an event
  def show
    #Rails.cache.clear
     #Rails.logger.debug("!! CACHE CLEARED")

  	 @event = Event.find(params[:id])
  	 @user = User.find(session[:user_id])

  end

  # instantiate a new event for create
  def new
  	@event = Event.new
  end

  # create an event. Save its creator and params
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
      # TODO does this reload the new template with the same fields as
      # previously entered, so students don't have to rewrite everything
      # about their events?
    end
  end

  # todo: edit
  def edit
  end

  # todo: delete
  def delete
  end

  # handle 'attend' button click
  def attend

    #Rails.cache.clear
    #Rails.logger.debug("!!!!cache clear")


  	@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])

    # add or remove user when button is clicked
    # based on whether or not the user is currently an attendee
    if @event.users.exclude?(@attendee)
      @event.users << @attendee
      @event.save
    else
      @event.users.delete(@attendee)
    end

    @attendees = @event.users

    # respond to: calls attend.js.erb
    respond_to do |format|
      format.js
      format.html { redirect_to(@event) }
    end
  end


  private

  # for strong params for a new event
  def event_params
    # same as using "params[:event]", except that it:
    # - raises and error if :event is not present
    # - allows listed attributes to be mass assigned
    params.require(:event).permit(:event_name, :location, :event_description,
      :start_time, :end_time, :category)
  end
end
