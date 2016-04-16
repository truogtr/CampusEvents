json.array!(@events) do |event|
	#Rails.logger.debug("IN JSON LAND")
	json.extract! event, :id, :event_name, :event_description
	json.start event.start_time
	json.end event.end_time
  #json.extract! event, :id, :event_name, :event_description, :created_at, :updated_at
  json.url event_url(event, format: :html)
end