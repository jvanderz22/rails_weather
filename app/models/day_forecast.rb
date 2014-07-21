class DayForecast < ActiveRecord::Base
  validates :temperature, :temperature_type, :day, presence: true
end
