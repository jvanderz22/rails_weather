require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HourForecastHelper. For example:
#
# describe HourForecastHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HourlyForecastHelper, :type => :helper do
  describe "convert_to_percentage" do
    it "returns a percentage string for a given number" do
      expect(convert_to_percentage(0)).to eq("0%")
      expect(convert_to_percentage(0.56)).to eq("56%")
      expect(convert_to_percentage(1)).to eq("100%")
    end
    it "rounds to two decimal places" do
      expect(convert_to_percentage(0.821111)).to eq("82%")
      expect(convert_to_percentage(0.8574)).to eq("86%")
    end
  end
  describe "date_from_time" do
    it "returns a date string from a datetime" do
      time = Time.new(2014, 7, 21, 20, 00, 00, "+00:00")
      expect(date_from_time(time, -5)).to eq("7/21/2014")
      expect(date_from_time(time, 5)).to eq("7/22/2014")
    end
  end
  describe "hour_from_time" do
    it "returns a localized hour from a datetime" do
      time = Time.new(2014, 7, 21, 20, 00, 00, "+00:00")
      offset = -5
      expect(hour_from_time(time, offset)).to eq("3 PM")
    end
  end
end
