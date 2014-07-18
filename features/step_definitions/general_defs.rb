Given /^I can connect to the internet$/ do
  daily_forecast = File.read('spec/files/national_weather_service.html')
  stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => daily_forecast, :headers => {})
  hourly_forecast = File.read('spec/files/hourly_forecast.html')
  stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital").
    with(:headers => {'Accept'=>'*/*','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => hourly_forecast, :headers => {})


end

Then /^I should see "(.+)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^"(.+)" should be a link to "(.+)"$/ do |link_text, page_name|
  expect(page).to have_link(link_text, :href => page_name)
end
