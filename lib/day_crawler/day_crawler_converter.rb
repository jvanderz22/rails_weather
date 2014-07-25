class DayCrawlerConverter
  def initialize(raw_forecasts)
    @raw_forecasts = raw_forecasts
  end

  def forecast
    @forecast ||= create_forecast
  end

  private

  def create_forecast
    days = @raw_forecasts.select do |raw_forecast|
      raw_forecast[:temperature_type] == "High"
    end
    converted_days(days)
    end

  def converted_days(days)
    days.map do |day|
      weekday = day[:day] == "This Afternoon" ? "Today" : day[:day]
      {
        weekday: weekday,
        day_present: true,
        high: day[:temperature],
        day_details: day[:details],
        night_present: false,
        low: nil,
        night_details: nil
      }
    end
    add_nights(days)
  end

  def nights_hash
   # @raw_forecasts.select do |result, day|
    #  result[day[:day].sub(" Night", "")] = day if day[:temperature_type] == "Low"
     # result
    #end
    #@raw_forecasts.select{|day| day if }.map{|x| x}
  end

  def add_nights(days)
    nights = nights_hash
    days.map do |day|
      night = day == "Today" ? nights["Tonight"] : nights[day[:weekday]]
      unless night.nil?
        day[:night_present] = true
        day[:low] = night[:temperature]
        day[:night_details] = night[:details]
      end
    end
    days.unshift(nights["Tonight"]) unless days[0][:weekday] == "Today"
    days
  end

  def tonight(day)
    { weekday: "Today",
      day_present: false,
      high: nil,
      days_details: nil,
      night_present: true,
      low: day[:temperature],
      night_details: day[:details]
    }
  end
end
