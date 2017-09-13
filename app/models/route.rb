class Route
  include Mongoid::Document
  include Mongoid::Timestamps

  field :passphrase, type: String
  field :source, type: String
  field :start_node, type: String
  field :end_node, type: String
  field :start_time, type: ActiveSupport::TimeWithZone
  field :end_time, type: ActiveSupport::TimeWithZone


  # validates_presence_of :username, :password
  # validates_uniqueness_of :username
  # validates_inclusion_of :role, in: %w(guest admin)
end