class NodePair
  include Mongoid::Document
  include Mongoid::Timestamps

  field       :id, type: String
  field :start_node, type: String
  field :end_node, type: String

  # validates_presence_of :username, :password
  # validates_uniqueness_of :username
  # validates_inclusion_of :role, in: %w(guest admin)
end