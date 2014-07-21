class HourlyForecastController < ApplicationController
  def index
    @hours = HourForecast.all
  end
end
