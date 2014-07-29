require 'nokogiri'
require 'open-uri'

class DayCrawler
  attr_reader :forecast
  def initialize
    uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.8500262820005&lon=-87.65004892899964&site=all&smap=1#.U7w8uY1dXi5")
    @doc = Nokogiri::HTML(open(uri))
    @weekly_forecast = {}
  end

  def forecast
    @forecast ||= create_forecast
  end

  private

  def create_forecast
    css = '#point_forecast_details > .two-third-first > .point-forecast-7-day > li'
    days = @doc.css(css).map do |day|
      forecast_type(day) == "Day" ? day_hash(day) : night_hash(day)
    end
    combine_days(days)
  end

  def combine_days(days)
    days.map do |day|
      corresponding_day = days.detect do |matching_day|
        matching_day[:day] == day[:day] && matching_day != day
      end
      if corresponding_day.nil?
        corresponding_day = day[:day_recorded] ? empty_night_hash : empty_day_hash
      end
      day.merge(corresponding_day)
    end.uniq
  end

  def empty_day_hash
    {
      day_recorded: false,
      high: nil,
      day_details: nil
    }
  end

  def empty_night_hash
    {
      night_recorded: false,
      low: nil,
      night_details: nil
    }
  end

  def day_hash(day)
    {
      day: day(day),
      day_recorded: true,
      high: temp(day),
      day_details: details(day)
    }
  end

  def night_hash(day)
    {
      day: day(day),
      night_recorded: true,
      low: temp(day),
      night_details: details(day)
    }
  end

  def day(day_html)
    first_child_empty?(day_html) ? index = 1 : index = 0
    day = day_html.children[index].content
    day = "Today" if ["Tonight", "This Afternoon", "Late Afternoon"].include?(day)
    day.sub(" Night", "")
  end

  def temp(day_html)
    temp_string = find_temp_string(day_html)
    temp_string[/\d+/].to_i
  end

  def forecast_type(day_html)
    !!(find_temp_string(day_html) =~ /high|temperature/) ? "Day" : "Night"
  end


  def find_temp_string(day_html)
    forecast_string = details(day_html)
    forecast_string[/high near (\d+)/] || forecast_string[/low around (\d+)/] ||
      forecast_string[/temperature around (\d+)/]
  end

  def first_child_empty?(html)
    html.content[0].strip.empty?
  end

  def details(day_html)
    first_child_empty?(day_html) ? index = 2 : index = 1
    day_html.children[index].content.strip
  end
end
