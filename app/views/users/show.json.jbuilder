# help here: https://richonrails.com/articles/getting-started-with-jbuilder

json.array!(@event_commitments) do |commitment|
	json.description commitment.description
	event = commitment.event
	json.extract! event, :id, :event_name, :event_description  # id refers to event_id
	json.start event.start_time
	json.end event.end_time
  json.url event_url(event, format: :html)
end
