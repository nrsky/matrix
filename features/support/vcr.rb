require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'spec/cassettes'
  c.default_cassette_options = { :record => :none }
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tag '@vcr_loopholes'
  t.tag  '@vcr'
end

Before('@vcr') { VCR.insert_cassette('loopholes', :record => :none) }
After('@vcr') { VCR.eject_cassette }