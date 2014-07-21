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
    forecast_array = []
    date = data[:date][0] + '/' + get_year_today
    (0..23).each do |hour_num|
      date = data[:date][1] + '/' + get_year_tomorrow if is_tomorrow?(hour_num)
      forecast_array << create_hour(hour_num, date)
    end
    forecast_array
  end

   def is_tomorrow?(hour_num)
     data[:time][hour_num] == "00" && hour_num != 0
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

  def create_hour(hour_num, date)
    {
      :time => create_time(data[:time][hour_num], date),
      :temperature => data[:temp][hour_num].to_i,
      :precipitation => data[:precip][hour_num].to_f / 100,
      :humidity => data[:humidity][hour_num].to_f / 100,
      :sky_cover => data[:sky_cover][hour_num].to_f / 100,
      :wind => data[:wind][hour_num].to_i
    }
  end

  def create_time(time, date)
    date_split = date.split('/')
    Time.local(date_split[2], date_split[0], date_split[1], time, "00", "00")
  end
end
