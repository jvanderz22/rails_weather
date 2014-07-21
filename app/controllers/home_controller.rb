class HomeController < ApplicationController
  def index
    @current_condition = CurrentForecast.get_forecast
  end

end
