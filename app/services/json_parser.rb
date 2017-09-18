module Json_Parser
  def self.parse_json(file)
    data = JSON.parse File.new(file).read
    key = data.keys.first

    data[key].map do |route|
      route.symbolize_keys!
      if route[:id].present?
        single_name = data.keys.first[0...-1]
        route.symbolize_keys!.update("#{single_name}_id": route[:id]).except!(:id)
      else
        route
      end
    end
  end
end