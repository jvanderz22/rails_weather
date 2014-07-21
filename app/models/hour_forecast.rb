class HourForecast < ActiveRecord::Base
  validates :time, :temperature, :precipitation,
    :humidity, :wind, :sky_cover, presence: true

end
