require 'rails_helper'

RSpec.describe HourForecast, :type => :model do
  it "has a valid model" do
    expect(create(:hour_forecast)).to be_valid
  end

  it "is not valid without a time" do
    expect(build(:hour_forecast, time: nil)).to be_invalid
  end

  it "is not valid without a temperature" do
    expect(build(:hour_forecast, temperature: nil)).to be_invalid
  end

  it "is not valid without a precipitation" do
    expect(build(:hour_forecast, precipitation: nil)).to be_invalid
  end

  it "is not valid without a humidity" do
    expect(build(:hour_forecast, humidity: nil)).to be_invalid
  end

  it "is not valid without a wind" do
    expect(build(:hour_forecast, wind: nil)).to be_invalid
  end

  it "is not valid without a sky_cover" do
    expect(build(:hour_forecast, sky_cover: nil)).to be_invalid
  end

  describe ".forecast" do
    def uploaded_forecasts(time_offset)
      (0..23).map do |index|
        now = Time.now.utc
        next_hour = now.hour + time_offset
        forecast_time = Time.new(now.year, now.month, now.day, next_hour, "00", "00", "+00:00")
        forecast_time += (index * 60 * 60)
        create(:hour_forecast, time: forecast_time)
      end
    end
    it "returns 24 future forecasts in the database" do
      upload = uploaded_forecasts(1)
      forecast = HourForecast.forecast
      expect(forecast.length).to eq(24)
      expect(forecast).to eq(upload)
    end
    it "does not return the same forecast if the first forecast is in the past" do
      upload = uploaded_forecasts(0)
      expect(HourForecast.forecast).to_not eq(upload)
    end
    it "still returns 24 forecasts if the first forecast is in the past" do
      upload = uploaded_forecasts(0)
      expect(HourForecast.forecast.length).to eq(24)
    end

  end
end
