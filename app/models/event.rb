class Event < ActiveRecord::Base
  # relate events to users
  has_and_belongs_to_many :users


  
  searchable do
    text :event_name 
  end

  self.per_page = 5




  # Commented out junk that didn't work
	# scope :between, lambda {|start_time, end_time| {:conditions => ["? < starts_at and starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)] }}


=begin
  def self.between(start_time, end_time)
    where('start_at > :lo and start_at < :up',
      :lo => Event.format_date(start_time),
      :up => Event.format_date(end_time)
    )
  end

  def self.format_date(date_time)
   Time.at(date_time.to_i).to_formatted_s(:db)
  end

  def as_json(options = {})
    {
      :id => self.id,
      :title => self.event_name,
      :start => self.created_at,
      :end => self.updated_at,
      :allDay => allDay,
      :user_name => self.creator,
      :url => Rails.application.routes.url_helpers.events_path(id),
      :color => "green"
    }
  end
=end
	
end
