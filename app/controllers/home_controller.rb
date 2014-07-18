require 'current_crawler'

class HomeController < ApplicationController
  def index
    @current_condition = get_forecast
  end

  private

  def get_forecast
    current_forecast = CurrentForecast.all[0]
    if current_forecast.nil?
      get_new_forecast
    else
      check_current_forecast(current_forecast)
    end
  end

  def check_current_forecast(current_forecast)
    if is_old_forecast?(current_forecast)
      current_forecast.destroy
      get_new_forecast
    else
      current_forecast
    end
  end

  def is_old_forecast?(forecast)
    (Time.now.utc - forecast[:created_at])/60 > 30
  end

  def get_new_forecast
     new_current_forecast = CurrentCrawler.new.forecast
     CurrentForecast.create(new_current_forecast)
     CurrentForecast.all[0]
  end

 end
