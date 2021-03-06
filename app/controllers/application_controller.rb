=begin
1. Styled events index

2. Moved options bar out of application layout to prevent errors on access pages

3. Completed password validation

4. Added an image placeholder: 
http://stackoverflow.com/questions/9646549/default-url-in-paperclip-broke-with-asset-pipeline-upgrade
(the second answer)

5. Implemented Filtering using gem sunspot
after bundle install run:
rake sunspot:solr:start
before starting server 

to stop run:
rake sunspot:solr:stop


if not working try running
rake sunspot:reindex
and restarting the server
=end


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_filter :set_cache_headers
  #before_filter :reset_cache

  private

  # We'll use this as a before_action on most pages
  # Same as exercise files
  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to root_path
      return false # halts the before_action
    else
      return true
    end
  end

#attempt at clearing cache for back-button refresh problem. Didn't work
=begin
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "#{1.year.ago}"
    Rails.logger.debug("IN CACHE SETTINGS@@@@@@@")
  end
=end

end
