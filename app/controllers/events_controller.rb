class EventsController < ApplicationController

  # this uses views/layouts.application.html.erb which links the asset folder
  # we should probably contain this so that we have differnt user and an event layouts.
	layout 'events'
  before_action :confirm_logged_in

  # get events ordered by start time for index page
  def index
		# simply call filter with category "All"
		@cat = "All"
		filter
  end

  def search
		@time_range_to_search = Time.zone.now..1000.days.from_now

    # Rails.logger.debug("@@@@ Search PARAM #{params[:query]}")
    @search = Event.search do
			# with(:end_time, @time_range_to_search)
			# TODO the above "with" does not get events in the future, but the below
			# does. The below works for now, but the above would be more consistent
			# with the way our filter() action works.
			with(:end_time).greater_than(Time.zone.now)
      keywords(params[:query])
    end

    @filtered = @search.results.paginate(:page => params[:page], :per_page => 5)

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
		@time_range_to_search = Time.zone.now..1000.days.from_now

    # grabs name of button to sort by category
    @cat = params[:cat]
		@categories = ["Social", "Academic", "Sports and Recreation", "Arts", "Religion"]

		if @categories.include? @cat  # @cat is a recognized category
			# Note: use Time.zone instead of just Time in order to get a TimeWithZone
			# object for comparison with :end_time.
			@filtered = Event.where({end_time: @time_range_to_search,
															 category: @cat})
											 .order(start_time: :asc)
											 .paginate(:page => params[:page])
		else  # @cat is "All" or an unrecognized category
			@filtered = Event.where({end_time: @time_range_to_search})
											 .order(start_time: :asc)
											 .paginate(:page => params[:page])
		end

    # Rails.logger.debug("FILTERED RESET #{params[:cat]}")

    # respond to: calls filter.js.erb
    respond_to do |format|
      format.js
      format.html { } #, :params => {:filtered => @filtered} }
      #format.json { render json: {  } }
    end
  end

  # display an event
  def show
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

    if @event.save
			EventCommitment.create(:user => @creator, :event => @event, :description => "attend")
      flash[:notice] = 'Event created.'
      redirect_to event_path(@event.id)
    else
      render("new")
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

  # TODO: delete
  def delete
  end

  # handle 'attend' button click
  def attend
  	@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])

		# get @attendee's event_commitment with this event, if any
		@event_commitment = @attendee.event_commitments.where(:event_id => @event.id).first

		# create a new event_commitment, or change @event_commitment's description to "attend"
		if @event_commitment == nil
			@event_commitment = EventCommitment.create(:user => @attendee, :event => @event, :description => "attend")
		elsif @event_commitment.description != "attend"
			# use update_attributes b/c saves automatically
			@event_commitment.update_attributes(:description => "attend")
    end

    @event_commitments = @event.event_commitments(true)  # use "true" to reload info from the db

    # respond to: calls attend.js.erb
    respond_to do |format|
      format.js
      format.html { redirect_to(@event) }
    end
  end

	# handle 'watch' button click
	def watch
		@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])

		# get @attendee's event_commitment with this event, if any
		@event_commitment = @attendee.event_commitments.where(:event_id => @event.id).first

		# create a new event_commitment, or change @event_commitment's description to "watch"
		if @event_commitment == nil
			@event_commitment = EventCommitment.create(:user => @attendee, :event => @event, :description => "watch")
		elsif @event_commitment.description != "watch"
			# use update_attributes b/c saves automatically
			@event_commitment.update_attributes(:description => "watch")
    end

    @event_commitments = @event.event_commitments(true)  # use "true" to reload info from the db

    # respond to: calls watch.js.erb
    respond_to do |format|
      format.js
      format.html { redirect_to(@event) }
    end
	end

	# handle 'neither' button click
	def neither
		@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])

		# get @attendee's event_commitment with this event, if any
		@event_commitment = @attendee.event_commitments.where(:event_id => @event.id).first

		# delete @event_commitment if there is one
		if @event_commitment != nil
			@event.users.delete(@attendee)
    end

    @event_commitments = @event.event_commitments(true)  # use "true" to reload info from the db

    # respond to: calls neither.js.erb
    respond_to do |format|
      format.js
      format.html { redirect_to(@event) }
    end
	end

  private

  # for strong params for a new event
  def event_params
    # same as using "params[:event]", except that it:
    # - raises an error if :event is not present
    # - allows listed attributes to be mass assigned
    params.require(:event).permit(:event_name, :location, :event_description,
      :start_time, :end_time, :category)
  end
end
