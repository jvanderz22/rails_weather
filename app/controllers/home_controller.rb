class HomeController < ApplicationController
  def index
    @current_condition = CurrentForecast.forecast
  end

end
