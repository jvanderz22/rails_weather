require 'spec_helper'

RSpec.describe DayForecast, :type => :model do
  it "has a valid factory" do
    expect(create(:day_forecast)).to be_valid
  end

  it "is not be valid without a temperature" do
    expect(build(:day_forecast, temperature: nil)).to be_invalid
  end

  it "is not be valid without a temperature_type" do
    expect(build(:day_forecast, temperature_type: nil)).to be_invalid
  end

  it "is not be valid without a day" do
    expect(build(:day_forecast, day: nil)).to be_invalid
  end

end
