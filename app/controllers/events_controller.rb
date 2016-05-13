class EventsController < ApplicationController

  # this uses views/layouts.application.html.erb which links the asset folder
  # we should probably contain this so that we have differnt user and an event layouts.
	layout 'events'
  before_action :confirm_logged_in


  # get events ordered by start time for index page
  def index
  	#@events = Event.order(:start_time)

    @events = Event.all.paginate(:page => params[:page])#.order => 'created_at DESC'

    Rails.logger.debug("@@@@#{params[:filtered].blank?}")

    @filtered = Event.all.paginate(:page => params[:page])

    # TODO filter here (or with javascript on page?, no, better here, once
    # there's a lot of data) to only get the ones with end_time after right
    # now.

     #@events = Event.between(params['start'], params['end']) if (params['start'] && params['end'])

  end

   def search

    Rails.logger.debug("@@@@ Search PARAM #{params[:query]}")
    @search = Event.search do
      keywords(params[:query])
    end

    @filtered = @search.results

    @filtered = @filtered.paginate(:page => params[:page], :per_page => 5)

    #maintain query

    respond_to do |format|
      format.js
      format.html {}
      #format.html { render :action => "index" }
      #format.xml  { render :xml => @search }
    end
  end

  # filter events on index page
  def filter

    # grabs name of button to sort by category
    @cat = params[:cat]

    Rails.logger.debug("FILTERED RESET #{params[:cat]}")


    @filtered = Event.order(:start_time).paginate(:page => params[:page])


    if @cat == "Social"
      @filtered = Event.where(:category => "Social").paginate(:page => params[:page])

    elsif @cat == "Academic"
      @filtered = Event.where(:category => "Academic").paginate(:page => params[:page])
    elsif @cat == "Sports and Recreation"
      @filtered = Event.where(:category => "Sports and Recreation").paginate(:page => params[:page])
       #Rails.logger.debug("****ENTERED**** #{@filtered.size}")
    elsif @cat == "Arts"
      @filtered = Event.where(:category => "Arts").paginate(:page => params[:page])
    elsif @cat == "Religion"
      @filtered = Event.where(:category => "Religion").paginate(:page => params[:page])
    end

    # respond to: calls filter.js.erb
    respond_to do |format|
      format.js
      format.html { } #, :params => {:filtered => @filtered} }
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


    # Rails.logger.debug("****FOUND**** #{@event.users.first.first_name}")

    if @event.save
      @event.users << @creator
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
    @event = Event.find(params[:id])
  end

  def update

    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to event_path(@event)
    else
      render('edit')
    end

  end

  def destroy
     @event = Event.find(params[:id])
    @event.delete
    redirect_to events_path
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
			@event_commitment = EventCommitment.create(:user => @attendee, :event => @event, :description => "attend")
      # @event.users << @attendee
      # @event.save
			# TODO is this right?
			@event_commitment.save
			Rails.logger.debug("!!!!! @event.users: #{@event.users.all}")
    else
      @event.users.delete(@attendee)
    end

    @attendees = @event.users(true)  # use "true" to reload info from the db

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
