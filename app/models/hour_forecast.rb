require 'hour_crawler'

class HourForecast < ActiveRecord::Base
  validates :time, :temperature, :precipitation,
    :humidity, :wind, :sky_cover, presence: true

  def self.forecast
    found_forecasts = latest_forecast
    if found_forecasts.length == 24
      found_forecasts
    else
      delete_forecast(found_forecasts)
      create_new_forecast
    end
  end

  private

  def self.latest_forecast
    this_hour = Time.now.utc
    twenty_five_hours_ahead = Time.now.utc + (25 * 60 * 60)
    HourForecast.where("time > ? AND time < ?", this_hour, twenty_five_hours_ahead)
  end

  def self.create_new_forecast
    create!(HourCrawler.new.forecast)
  end

  def self.delete_forecast(forecasts)
    forecasts.each { |forecast| forecast.destroy }
  end
end
