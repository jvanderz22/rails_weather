module HourlyForecastHelper
  def convert_to_percentage(decimal)
    rounded = decimal.round(2)
    (100 * rounded).to_i.to_s + "%"
  end

  def date_from_time(time, offset)
    (time + (offset * 60 *60)).strftime("%-m/%d/%Y")
  end

  def hour_from_time(time, offset)
    (time + (offset * 60 * 60)).strftime("%l %p").lstrip
  end
end
