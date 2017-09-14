module Json_Parser
  def self.parse_json(file)
    data = JSON.parse File.new(file).read
    results = []

    if data.key?('routes')
      data['routes'].each do |route|
        Route.create(route)
        results << route
      end
    elsif data.key?('node_pairs')
      data['node_pairs'].each do |node_pair|
        results << node_pair
        # NodePair.create(node_pair)
      end
    end
    print NodePair.all.count
    results
  end
end