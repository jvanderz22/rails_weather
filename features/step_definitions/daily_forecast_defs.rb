Given /^I connect to the internet on Thursday$/ do
  daily_forecast = File.read('spec/files/national_weather_service.html')
  stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => daily_forecast, :headers => {})

end

Given /^I connect to the internet on Tuesday Night$/ do
  daily_forecast = File.read('spec/files/tuesday_night.html')
  stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => daily_forecast, :headers => {})
end

