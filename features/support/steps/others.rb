def write_vcr_example(cassette_name, url)
  VCR.use_cassette(cassette_name, record: :new_episodes) do
    uri = URI.parse(url)
    uri.port = $server.port if $server
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
  end
end
