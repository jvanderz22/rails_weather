class HourlyForecastController < ApplicationController
  respond_to :html, :json
  def index
    @hours = HourForecast.forecast
    respond_with(@hours)
  end
end
