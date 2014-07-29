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

Given /^I visit "(.+)"$/ do |page|
  visit(page)
end

Given /^I am signed in$/ do
  step 'I am signed up as email@email.com with password 12345678'
end

When /^I enter "(.+)" as my "(.+)"$/ do |text, field|
  field_sym = field.gsub(" ", "_").to_sym
  fill_in field_sym, with: text
end

When /^I press "(.+)"$/ do |button|
  click_on(button)
end

Then /^I should see "(.+)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^I should not be redirected from "(.+)"$/ do |path|
  expect(page.current_path).to eq(path)
end

Then /^I should see "(.*?)" "(\d+)" times$/ do |text, times|
  expect(page.text.scan(text).count).to eq(times.to_i)
end

Then /^"(.+)" should be a link to "(.+)"$/ do |link_text, destination|
  expect(page).to have_link(link_text, :href => destination)
end
