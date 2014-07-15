require 'nokogiri'
require 'open-uri'


class HourCrawler
  attr_reader :forecast
  def initialize
    @uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital")
    @forecast = []
  end


  def create_forecast
    date = "#{data[:date][0]}/#{get_year_today}"
    (0..23).each do |hour|
      tomorrow = data[:time][hour] == "00"  && hour != 0
      date = "#{data[:date][1]}/#{get_year_tomorrow}" if tomorrow
      @forecast << create_hour(hour, date)
    end
  end

  private

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
      :time => convert_time(data[:time][hour]),
      :temp => data[:temp][hour].to_i,
      :precip => data[:precip][hour] + "%",
      :humidity => data[:humidity][hour] + "%",
      :sky_cover => data[:sky_cover][hour] + "%",
      :wind => data[:wind][hour].to_i
    }
  end


  def convert_time(raw_time)
    int_time = raw_time.to_i
    if int_time == 0
      "12 AM"
    elsif int_time == 12
      "12 PM"
    elsif int_time < 12
      int_time.to_s + " AM"
    else
      (int_time - 12).to_s + " PM"
    end
  end
end
