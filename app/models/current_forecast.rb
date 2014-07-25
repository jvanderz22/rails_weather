require 'current_crawler'

class CurrentForecast < ActiveRecord::Base
  validates :temperature, :condition, :wind_speed, :humidity, presence: true

  def self.forecast
    forecast_for_today || fetch_new_forecast
  end

  private

  def self.forecast_for_today
    thirty_minutes_ago = Time.now.utc - (30 * 60)
    CurrentForecast.where('created_at > ?', thirty_minutes_ago).first
  end

  def self.fetch_new_forecast
    create!(CurrentCrawler.new.forecast)
  end
end
