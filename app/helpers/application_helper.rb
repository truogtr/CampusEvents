module ApplicationHelper

	 def error_messages_for(object)
    render(:partial => 'application/error_messages',
      :locals => {:object => object})
  end

  def filter 
		puts "called"
		 Rails.logger.debug("****GOT HERE****")
	end
  
end
