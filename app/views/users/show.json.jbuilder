# help here: https://richonrails.com/articles/getting-started-with-jbuilder
#
# json.array!(@events) do |event|
# 	Rails.logger.debug("IN JSON LAND")
# 	json.extract! event, :id, :event_name, :event_description
# 	json.start event.start_time
# 	json.end event.end_time
#   #json.extract! event, :id, :event_name, :event_description, :created_at, :updated_at
#   json.url event_url(event, format: :html)
# end


json.array!(@event_commitments) do |commitment|
	json.description commitment.description
	event = commitment.event
	Rails.logger.debug("IN JSON LAND")
	json.extract! event, :id, :event_name, :event_description  # id refers to event_id
	json.start event.start_time
	json.end event.end_time
  #json.extract! event, :id, :event_name, :event_description, :created_at, :updated_at
  json.url event_url(event, format: :html)
end



# json.array!(@event_commitments) do |json, commitment|
# 	# Rails.logger.debug("IN JSON LAND")
# 	json.description commitment.description  # watch or attend
# 	# get info from this commitment's event
#
# 	json.event commitment.event do |json, event|
# 		json.(event, :id, :event_name, :event_description)
# 		json.start event.start_time
# 		json.end event.end_time
# 	end
# #
# # 	# json.extract! event, :id, :event_name, :event_description
# # 	# json.start event.start_time
# # 	# json.end event.end_time
# #   json.url event_url(commitment, format: :html)
# # end
#
# {[
# 	event_id:
# 	event_name:
# 	event_description:
# 	start:
#   end:
# 	url:
# 	description: watch
# 	]}
