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

  describe ".get_forecast" do
    before(:each) do
      time = Time.now
      let(:upload_hash) {
        { time: time,
          temperature: 100,
          precipitation: 0.54,
          humidity: 0.60,
          wind: 6,
          sky_cover: 0.7
        }
      }
      let(:converted_hash {
        { date: time.month + '/' time.day + '/' time.year,
          hour: time.strfttime('%I %P %z -06)q
          temperature: 100,
          precipation: "54%",

      }
      }
    end
    it "returns a forecast in the database" do
      upload = create(:current_forecast)
      expect(CurrentForecast.get_forecast).to eq(upload)
    end
  end
end
