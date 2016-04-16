class User < ActiveRecord::Base

  # for encryption as in Exercise Files
	has_secure_password

  # Relate users to events
  has_and_belongs_to_many :events
  # TODO this represents what they're attending, but what about
  # what they're watching?
  # use "rich join" to see whether they have "joined" or "watched" the
  # event. See:
  # http://www.lynda.com/Ruby-Rails-tutorials/Many-many-associations-Rich/139989/159108-4.html?autoplay=true
  # And create a model for the "event_watching/attendees/attendance" or s'th like that
  # Now it will also have a primary key because it is its own table.
  # "event relationships" ?

  #attr_accessor :password_confirmation

  # For images
  has_attached_file :avatar,
    styles: {
      tiny:  '25x25#',
      small: '50x50#',
      thumb: '32x32#',
      square: '200x200#',
      medium: '300x300#'
    },
    :default_style => :small,
    :default_url => ':placeholder'


	#EMAIL_REGEX = /\A[a-z0-9._%+-]+@middlebury.edu\Z/i

	validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    #:format => EMAIL_REGEX,  # Commented out for testing
                    :uniqueness => true#,
                    #:confirmation => true

  validates :password,     #:presence => true,
                           :length => { :within => 4..15 }
                           #:confirmation => true

  #validates :password_confirmation, :presence => true

  # required validation for images
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
