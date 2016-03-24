class User < ActiveRecord::Base

	has_secure_password

  has_and_belongs_to_many :events

  has_attached_file :avatar, 
    styles: {
      tiny:  '25x25#',
      small: '50x50#', 
      thumb: '32x32#',
      square: '200x200#',
      medium: '300x300#'
    },
    :default_style => :small

	#EMAIL_REGEX = /\A[a-z0-9._%+-]+@middlebury.edu\Z/i

	validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    #:format => EMAIL_REGEX,
                    :uniqueness => true#,
                    #:confirmation => true

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
