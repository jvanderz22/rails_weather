require 'nokogiri'
require 'open-uri'
require 'pry'


#CREATE RAW DATA CLASS
class HourCrawler
  attr_reader :forecast
  RAW_HTML_LABELS = Regexp.union([/Date/, /Hour/, /Temperature/, /Surface Wind/,
                                  /Sky Cover/, /Precipitation Potential/,
                                  /Relative Humidity/])
  def initialize
    uri = URI("http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital")
    @doc = Nokogiri::HTML(open(uri))
    create_forecast
  end

  private

  def create_forecast
    @forecast = []
    parse_data
    convert_raw_data
  end

  def convert_raw_data
    cur_date = @raw_data[:date][0]
    (0..23).each do |index|
      hour = {}
      hour[:time] = convert_time(@raw_data[:time][index])
      cur_date = @raw_data[:date][1] if hour[:time] == "12 AM" && index != 0
      hour[:date] = cur_date
      hour[:temp] = @raw_data[:temp][index].to_i
      hour[:precip] = @raw_data[:precip][index] + "%"
      hour[:humidity] = @raw_data[:humidity][index] + "%"
      hour[:sky_cover] = @raw_data[:sky_cover][index] + "%"
      hour[:wind] = @raw_data[:wind][index].to_i
      @forecast << hour
    end
  end

  def convert_time(raw_time)
    int_time = raw_time.to_i
    return "12 AM" if int_time == 0
    return "12 PM" if int_time == 12
    if int_time < 12
      int_time.to_s + " AM"
    else
      (int_time - 12).to_s + " PM"
    end
  end

  def parse_data
    @raw_data = {}
    @doc.css("tr").each do |row|
      parse_row(row) if is_data_row?(row)
    end
  end

  def parse_row(row)
    label = find_label(row)
    return if @raw_data.has_key?(label)
    extract_data(label, row)
  end

  def find_label(row)
    raw_label = row.content.scan(RAW_HTML_LABELS)[0]
    convert_label(raw_label)
  end

  def convert_label(raw_label)
    raw_label_converter = { "Hour" => :time,
                            "Date" => :date,
                            "Temperature" => :temp,
                            "Surface Wind" => :wind,
                            "Sky Cover" => :sky_cover,
                            "Precipitation Potential" => :precip,
                            "Relative Humidity" => :humidity }
    raw_label_converter[raw_label]
  end

  def extract_data(label, row)
    @raw_data[label] = []
    label_pos = find_label_pos(row)
    row.children.each_with_index do |child, index|
      next if index <= label_pos
      data = child.content.strip
      @raw_data[label] << data unless data == ""
    end
  end

  def find_label_pos(row)
    row.children.each_with_index do |child, index|
      return index if !!(child.content.match(RAW_HTML_LABELS))
    end
  end

  def is_data_row?(row)
    return false if !!(row.content.match(/[\W]Hour/))
    row.content.scan(RAW_HTML_LABELS).length == 1
  end
end
