require 'day_crawler'

class DayForecast < ActiveRecord::Base
  validates :day, presence: true
  validates_inclusion_of :day_recorded, :night_recorded, in: [true, false]
  validate :detail_consistency, :high_and_low_consistency, :day_or_night_recorded

  def self.forecast
    found_forecast = latest_forecast
    if is_current_forecast?(found_forecast)
      found_forecast
    else
      delete_forecasts
      create_new_forecast
    end
  end

  def self.today
    forecast[0]
  end

  private

  def self.latest_forecast
    DayForecast.order(:created_at).limit(7)
  end

  def self.create_new_forecast
    forecast = DayCrawler.new.forecast
    create!(forecast)
  end

  def self.delete_forecasts
    DayForecast.all.each { |forecast| forecast.destroy }
  end

  def self.is_current_forecast?(forecasts)
    first_forecast = forecasts.first
    return false if first_forecast.nil? ||  first_forecast[:day] != "Today"
    first_forecast.created_at.to_date == DateTime.now.utc.to_date
  end

  def detail_consistency
    unless statuses_match?(day_details, day_recorded) &&
      statuses_match?(night_details, night_recorded)
        errors.add(:base, "Details must be consistently
                   present with recorded day or night status")
    end
  end

  def high_and_low_consistency
    unless statuses_match?(high, day_recorded) &&
      statuses_match?(low, night_recorded)
        errors.add(:base, "High and low temperatures must be consistently present with
               recorded day or night status respectively")
     end
  end

  def day_or_night_recorded
    unless day_recorded || night_recorded
      errors.add(:base, "Either day or night must be recorded")
    end
  end

  def statuses_match?(potential_blank_field, time_recorded)
    potential_blank_field.blank? != time_recorded
  end
end

