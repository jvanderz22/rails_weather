require 'current_crawler'

class CurrentForecast < ActiveRecord::Base
  validates :temperature, :condition, :wind_speed, :humidity, presence: true
  def self.get_forecast
    current_forecast = all[0]
    if current_forecast.nil?
      get_new_forecast
    else
      check_current_forecast(current_forecast)
    end
  end

  private

  def self.check_current_forecast(current_forecast)
    if is_old_forecast?(current_forecast)
      current_forecast.destroy
      get_new_forecast
    else
      current_forecast
    end
  end

  def self.is_old_forecast?(forecast)
    (Time.now.utc - forecast[:created_at])/60 > 30
  end

  def self.get_new_forecast
     new_current_forecast = CurrentCrawler.new.forecast
     create(new_current_forecast)
     all[0]
  end
end
