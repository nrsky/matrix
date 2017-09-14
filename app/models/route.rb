class Route
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic


  TYPES = ['alpha', 'beta', 'gamma', 'delta', 'theta', 'lambda', 'tau', 'psi', 'omega']
  SOURCES = ['sentinels', 'sniffers', 'loopholes']

  field       :id, type: String
  field :passphrase, type: String
  field :source, type: String
  field :start_node, type: String
  field :end_node, type: String
  field :start_time, type: ActiveSupport::TimeWithZone
  field :end_time, type: ActiveSupport::TimeWithZone

  validates_inclusion_of  :source, in: SOURCES, allow_nil: true
  validates_inclusion_of :start_node, in: TYPES, allow_nil: true
  validates_inclusion_of :end_node, in: TYPES, allow_nil: true
  validates_length_of :passphrase, minimum: 23, maximum: 23, allow_nil: true
  # start_time	ISO 8601 UTC time	YYYY-MM-DDThh:mm:ss
  # end_time	ISO 8601 UTC time	YYYY-MM-DDThh:mm:ss
end