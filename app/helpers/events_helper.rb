module EventsHelper

	def filter
		puts "called"
		 Rails.logger.debug("****GOT HERE****")
	end

	# TODO are these being used?

	def attend
			puts "called"
		 Rails.logger.debug("****GOT HERE****")
	end

	def set_buttons(button_text, button_class)
		@event = Event.find(params[:id])
  	@attendee = User.find(session[:user_id])

		# get @attendee's event_commitment with this event, if any
		@event_commitment = @attendee.event_commitments.where(:event_id => @event.id).first

		# default values
		button_text["attend"] = "Attend"
		button_text["watch"] = "Watch"
		button_text["neither"] = "Neither"

		button_class["attend"] = "unselected_button"
		button_class["watch"] = "unselected_button"
		button_class["neither"] = "unselected_button"

		if @event_commitment == nil
			button_class["neither"] = "selected_button"
		elsif @event_commitment.description == "attend"
			button_class["attend"] = "selected_button"
			button_text["attend"] = "Attending"
		elsif @event_commitment.description == "watch"
			button_class["watch"] = "selected_button"
			button_text["watch"] = "Watching"
    end
	end
end
