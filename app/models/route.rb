class Route
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic


  TYPES = ['alpha', 'beta', 'gamma', 'delta', 'theta', 'lambda', 'tau', 'psi', 'omega']

  field       :id, type: String
  field :passphrase, type: String
  field :source, type: String
  field :start_node, type: String
  field :end_node, type: String
  field :start_time, type: ActiveSupport::TimeWithZone
  field :end_time, type: ActiveSupport::TimeWithZone

  validates_inclusion_of :start_node, in: TYPES, :allow_nil => true
  validates_inclusion_of :end_node, in: TYPES, :allow_nil => true
  validates_length_of :passphrase, :minimum => 23, :maximum => 23, :allow_nil => true


  # validates_presence_of :username, :password
  # validates_uniqueness_of :username
  # validates_inclusion_of :role, in: %w(guest admin)


  # passphrase	fasten your seat belt Dorothy	XXXXXXXXXXXXXXXXXXXXXXX
  # source	alphanumeric code	sentinels, sniffers, loopholes
  # start_time	ISO 8601 UTC time	YYYY-MM-DDThh:mm:ss
  # end_time	ISO 8601 UTC time	YYYY-MM-DDThh:mm:ss
end