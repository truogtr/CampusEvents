class User < ActiveRecord::Base

  attr_accessor :do_val
  #attr_accessor   :password, :password_confirmation
  #attr_accessible :password, :password_confirmation
  # for encryption as in Exercise Files
	has_secure_password

  # Relate users to events
  # has_and_belongs_to_many :events
  has_many :event_commitments, :dependent => :destroy
  has_many :events, :through => :event_commitments

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


  EMAIL_REGEX = /\A[a-z0-9._%+-]+@middlebury.edu\Z/i

  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,  # Commented out for testing
                    :uniqueness => true#,
                    #:confirmation => true

  # TODO add password validation
  # TODO add email password
  validates :password,     #:presence => true,
                           :length => { :within => 4..15 }, if: :do_val
                           #:confirmation => true
                            #on: :update, allow_blank: true,

  #validates :password, length: {minimum: 4, maximum: 120}

  #validates :password_confirmation, :presence => true

  #validates_confirmation_of :password, :on => :update
  #validates_presence_of :password_confirmation, :on => :update

  # required validation for images
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
