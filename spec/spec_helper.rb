require 'day_crawler'
require 'hour_crawler'
require 'current_crawler'
require 'webmock/rspec'
require 'capybara/rspec'
require 'factory_girl_rails'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end


  config.before(:each) do
    daily_forecast = File.read('spec/files/national_weather_service.html')
    stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3','User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => daily_forecast, :headers => {})

    hourly_forecast = File.read('spec/files/hourly_forecast.html')
    stub_request(:get, "http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital").
      with(:headers => {'Accept'=>'*/*','Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => hourly_forecast, :headers => {})
  end
end
