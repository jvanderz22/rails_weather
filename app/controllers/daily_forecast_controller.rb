class DailyForecastController < ApplicationController
  respond_to :html, :json
  def index
    @days = DayForecast.forecast
    respond_with(@days)
  end
end
