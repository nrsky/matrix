Given(/^a route with source "(.*?)"$/) do |source|
  @route = given_a_route(source)
end

Given(/^routes with source "(.*?)"$/) do |source|
  3.times do
    FactoryGirl.create(:route, source: source)
  end
end

def given_a_route(source)
  FactoryGirl.create(:route,
                     source: source,
                     passphrase:"Kans4s-i$-g01ng-by3-bye",
                     start_node: 'beta',
                     end_node: 'alpha',
                     start_time: '2017-09-25T11:55:29.562Z',
                     end_time: '2017-09-25T11:56:29.562Z' )
end