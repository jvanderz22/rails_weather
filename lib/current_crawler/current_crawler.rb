require 'nokogiri'
require 'open-uri'

class CurrentCrawler
  attr_reader :forecast
  def initialize
    uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1#.U7w8uY1dXi5")
    @doc = Nokogiri::HTML(open(uri))
  end

  def forecast
    @forecast ||= create_forecast
  end

  private

  def create_forecast
    @forecast = {
      :temperature => get_temperature,
      :condition => get_condition,
      :humidity => get_humidity,
      :wind_speed => get_wind_speed
    }
  end

  def get_temperature
    temp_string = @doc.css("#current_conditions > .div-half-right > .myforecast-current-lrg")[0].content
    temp_string[/(\d+)/].to_i
  end

  def get_condition
    @doc.css("#current_conditions > .div-half-right > .myforecast-current")[0].content
  end

  def get_humidity
    @doc.css("#current_conditions_detail > ul > li")[0].content[/\d+/].to_i
  end

  def get_wind_speed
    @doc.css("#current_conditions_detail > ul > li")[1].content.sub("Wind Speed", "")
  end
end
