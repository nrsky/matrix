module Json_Parser
  def self.parse_json(file)
    data = JSON.parse File.new(file).read
    if data.key?('routes')
      data['routes'].each do |route|
        Route.create(route)
      end
    elsif data.key?('node_pairs')
      data['node_pairs'].each do |node_pair|
        NodePair.create(node_pair)
      end
    end
    print NodePair.all.count
  end
end