require 'nokogiri'
require 'open-uri'


class HourCrawler
  attr_reader :forecast
  def initialize
    @uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital")
  end

  def forecast
    @forecast ||= create_forecast
  end

  private

  def create_forecast
    @forecast = []
    date = "#{data[:date][0]}/#{get_year_today}"
    (0..23).each do |hour|
      tomorrow = data[:time][hour] == "00"  && hour != 0
      date = "#{data[:date][1]}/#{get_year_tomorrow}" if tomorrow
      @forecast << create_hour(hour, date)
    end
    @forecast
  end

  def data
    @raw_data ||= DataExtractor.new(Nokogiri::HTML(open(@uri))).data
  end

  def get_year_today
    Date.today.strftime("%Y")
  end

  def get_year_tomorrow
    Date.today.succ.strftime("%Y")
  end

  def create_hour(hour, date)
    hour = {
      :date => date,
      :hour => convert_hour(data[:time][hour]),
      :temperature => data[:temp][hour].to_i,
      :precipitation => data[:precip][hour].to_f / 100,
      :humidity => data[:humidity][hour].to_f / 100,
      :sky_cover => data[:sky_cover][hour].to_f / 100,
      :wind => data[:wind][hour].to_i
    }
  end


  def convert_hour(raw_hour)
    int_hour = raw_hour.to_i
    if int_hour == 0
      "12:00 AM"
    elsif int_hour == 12
      "12:00 PM"
    elsif int_hour < 12
      int_hour.to_s + ":00 AM"
    else
      (int_hour - 12).to_s + ":00 PM"
    end
  end
end
