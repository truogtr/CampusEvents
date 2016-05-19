class Event < ActiveRecord::Base
  # relate events to users
  # has_and_belongs_to_many :users
  has_many :event_commitments, :dependent => :destroy
  has_many :users, :through => :event_commitments

  searchable do
    text :event_name, :default_boost => 2
    text :event_description
    time :end_time
  end

  self.per_page = 5

  validates :event_name,        :presence => true,
                                :length => { :maximum => 50 }
  validates :location,          :presence => true,
                                :length => { :maximum => 255 }
  validates :event_description,
                                :length => { :maximum => 65535 }

  validate :start_time_in_future
  validate :end_time_after_start_time

  def start_time_in_future
    # add an error if the start_time is before the start of current hour
    if start_time < Time.zone.now.beginning_of_hour
      errors.add(:start_time, "cannot be in the past.")
    end
  end

  def end_time_after_start_time
    # add an error if end_time is before start_time
    if end_time < start_time
      errors.add(:end_time, "cannot be before start time.")
    end
  end


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
