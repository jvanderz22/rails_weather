require 'nokogiri'
require 'open-uri'
require 'pry'

class SevenDayCrawler
  attr_reader :forecast
  def initialize
    uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1#.U7w8uY1dXi5")
    @doc = Nokogiri::HTML(open(uri))
    create_forecast
  end

  private

  def create_forecast
    @forecast = []
    css = '#point_forecast_details > .two-third-first > .point-forecast-7-day > li'
    @doc.css(css).each do |day|
      day_hash = {}
      day_hash[:day] = find_day(day)
      day_hash[:temp] = find_temp(day)
      day_hash[:temp_type] = find_temp_type(day)
      @forecast <<  day_hash
    end
  end

  def find_day(day_html)
    if first_child_empty?(day_html)
      day_html.children[1].content
    else
      day_html.children[0].content
    end
  end

  def find_temp(day_html)
    temp_string = find_temp_string(day_html)
    temp_string[/\d+/].to_i
  end

  def find_temp_type(day_html)
    if find_temp_string(day_html) =~ /high/
      "High"
    else
      "Low"
    end
  end


  def find_temp_string(day_html)
    forecast_string = day_html.children[1].content unless first_child_empty?(day_html)
    forecast_string ||= day_html.children[2].content
    forecast_string[/high near (\d+)/] || forecast_string[/low around (\d+)/]
  end

  def first_child_empty?(html)
    !!(html.children[0].content =~ /^\s*$/)
  end
end
