module ApplicationHelper

  # same as Exercise Files
  def error_messages_for(object)
    render(:partial => 'application/error_messages',
      	   :locals => {:object => object})
  end



end
