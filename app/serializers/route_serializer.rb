# app/serializers/route_serializer.rb
class RouteSerializer < ActiveModel::Serializer
  attributes :passphrase, :source, :start_node, :end_node, :start_time, :end_time

  def start_time
    object.start_time.iso8601
  end

  def end_time
    object.end_time.iso8601
  end
end