require 'rails_helper'

RSpec.describe CurrentForecast, :type => :model do
  it "has a valid model" do
    expect(create(:current_forecast)).to be_valid
  end

  it "is not valid without a temperature" do
    expect(build(:current_forecast, temperature: nil)).to be_invalid
  end

  it "is not valid without a condition" do
    expect(build(:current_forecast, condition: nil)).to be_invalid
  end

  it "is not valid without a wind_speed" do
    expect(build(:current_forecast, wind_speed: nil)).to be_invalid
  end

  it "is not valid without a humidity" do
    expect(build(:current_forecast, humidity: nil)).to be_invalid
  end

  describe ".get_forecast" do
    it "returns a forecast in the database" do
      upload = create(:current_forecast)
      expect(CurrentForecast.get_forecast).to eq(upload)
    end
    it "returns a forecast that was created less than 30 minutes ago" do
      upload_recent = create(:current_forecast, created_at: Time.now.utc - (28*60))
      expect(CurrentForecast.get_forecast).to eq(upload_recent)
    end
    it "doesn't return a forecast that was created more than 30 minutes ago" do
      upload_past = create(:current_forecast, created_at: Time.now.utc - (31 * 60))
      expect(CurrentForecast.get_forecast).not_to eq(upload_past)
    end
  end

end
