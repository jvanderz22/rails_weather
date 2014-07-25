require 'spec_helper'

RSpec.describe DayForecast, :type => :model do
  it "has a valid factory" do
    expect(create(:day_forecast)).to be_valid
  end

  it "is not valid without a weekday" do
    expect(build(:day_forecast, day: nil)).to be_invalid
  end

  it "is not valid without either day_recorded or night_recorded" do
    expect(build(:day_forecast, day_recorded: false, night_recorded: false)).to be_invalid
  end

  it "is not valid if day_recorded and high are not synced" do
    expect(build(:day_forecast, day_recorded: true, high: nil)).to be_invalid
    expect(build(:day_forecast, day_recorded: false, high: 56)).to be_invalid
  end

  it "is not valid if day_recorded and details_day are not synced" do
    expect(build(:day_forecast, day_recorded: true,
                 day_details: nil)).to be_invalid
    expect(build(:day_forecast, day_recorded: false,
                 day_details: "Details")).to be_invalid
  end

  it "is not valid if night_recorded and low are not synced" do
    expect(build(:day_forecast, night_recorded: true, low: nil)).to be_invalid
    expect(build(:day_forecast, night_recorded: false, low: 45)).to be_invalid
  end

  it "is not valid if night_recorded and details_night are not synced" do
    expect(build(:day_forecast, night_recorded: true,
                 night_details: nil)).to be_invalid
    expect(build(:day_forecast, night_recorded: false,
                 night_details: "Details")).to be_invalid
  end
  describe ".forecast" do
    let (:days_from_today) { ["Today", "Tuesday", "Wednesday", "Thursday",
      "Friday", "Saturday", "Sunday"] }

    def uploaded_forecast(upload_array, created_at = DateTime.now)
      upload_array.map.with_index do |day, index|
        if index == upload_array.length - 1
         create(:day_forecast, day: day, created_at: created_at, night_recorded: false,
                night_details: nil, low: nil)
        else
          create(:day_forecast, day: day, created_at: created_at)
        end
      end
    end

    it "returns forecasts uploaded today" do
      upload_from_today = uploaded_forecast(days_from_today)
      expect(DayForecast.forecast).to eq(upload_from_today)
    end

    it "returns updated forecasts if the forecast was not created today" do
      uploaded_yesterday = uploaded_forecast(days_from_today, DateTime.now - 1)
      forecast = DayForecast.forecast
      expect(forecast).to_not eq(uploaded_yesterday)

      expect(forecast.length).to eq(7)
    end

    it "returns new forecasts if the first forecast in the database is not from today" do
      not_today_forecasts = uploaded_forecast(days_from_today[0...-1].unshift("Sunday"))
      forecast = DayForecast.forecast
      expect(forecast).to_not eq(not_today_forecasts)
      expect(forecast.length).to eq(7)
    end
  end
end
