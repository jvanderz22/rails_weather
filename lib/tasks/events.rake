require 'hour_crawler'
require 'day_crawler'
require 'current_crawler'

namespace :events do
  desc "Scrape a daily forecast off the web"
  task day_scraper: :environment do
    forecasts = DayCrawler.new.forecast
    forecasts.each do |forecast|
      DayForecast.create(forecast)
    end
  end

  desc "Scrape an hourly forecast off the web and add it to the database"
  task hour_scraper: :environment do
    forecasts = HourCrawler.new.forecast
    forecasts.each do |forecast|
      HourForecast.create(forecast)
    end
  end

  desc "Scrape a current forecast off the web and add it to the database"
  task current_scraper: :environment do
    forecast = CurrentCrawler.new.forecast
    CurrentForecast.create(forecast)
  end
end
