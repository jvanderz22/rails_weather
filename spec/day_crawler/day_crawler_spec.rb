describe DayCrawler do
  raw_forecast = [
    {:day=>"This Afternoon", :temperature=>70, :temperature_type=>"High", :details=>"Sunny, with a high near 70. Northeast wind 5 to 10 mph."},
    {:day=>"Tonight", :temperature=>62, :temperature_type=>"Low", :details=>"Mostly clear, with a low around 62. Northeast wind 5 to 10 mph becoming south after midnight."},
    {:day=>"Friday", :temperature=>76, :temperature_type=>"High", :details=>"A 30 percent chance of showers and thunderstorms after 2pm.  Partly sunny, with a high near 76. South southwest wind 5 to 15 mph."},
    {:day=>"Friday Night", :temperature=>67, :temperature_type=>"Low", :details=>"A 50 percent chance of showers and thunderstorms.  Mostly cloudy, with a low around 67. South wind around 10 mph, with gusts as high as 15 mph."},
    {:day=>"Saturday", :temperature=>84, :temperature_type=>"High", :details=>"A 50 percent chance of showers and thunderstorms.  Partly sunny, with a high near 84. South wind 5 to 10 mph becoming west in the afternoon."},
    {:day=>"Saturday Night", :temperature=>69, :temperature_type=>"Low", :details=>"A 40 percent chance of showers and thunderstorms, mainly before 8pm.  Partly cloudy, with a low around 69."},
    {:day=>"Sunday", :temperature=>79, :temperature_type=>"High", :details=>"A 40 percent chance of showers and thunderstorms, mainly after 8am.  Partly sunny, with a high near 79."},
    {:day=>"Sunday Night", :temperature=>63, :temperature_type=>"Low", :details=>"A chance of showers and thunderstorms.  Mostly cloudy, with a low around 63."},
    {:day=>"Monday", :temperature=>72, :temperature_type=>"High", :details=>"A slight chance of showers and thunderstorms.  Mostly sunny, with a high near 72."},
    {:day=>"Monday Night", :temperature=>61, :temperature_type=>"Low", :details=>"Partly cloudy, with a low around 61."},
    {:day=>"Tuesday", :temperature=>74, :temperature_type=>"High", :details=>"Mostly sunny, with a high near 74."},
    {:day=>"Tuesday Night", :temperature=>63, :temperature_type=>"Low", :details=>"Partly cloudy, with a low around 63."},
    {:day=>"Wednesday", :temperature=>76, :temperature_type=>"High", :details=>"Partly sunny, with a high near 76."}
  ]
  let (:day_crawler) { DayCrawler.new }
  let(:forecast) { day_crawler.forecast }

  describe "#forecast" do
   it "returns an array of day hashes" do
      expect(forecast).to be_kind_of(Array)
      expect(forecast[0]).to be_kind_of(Hash)
    end
    it "returns 7 days" do
      expect(forecast.length).to eq(7)
    end
    it "should set the first day to be 'Today'" do
      expect(forecast[0][:day]).to eq("Today")
    end
    it "should set the last day to be 'Wednesday'" do
      expect(forecast[-1][:day]).to eq("Wednesday")
    end
    it "should set the day temperatures to be highs" do
      expect(forecast[0][:high]).to eq(75)
      expect(forecast[1][:high]).to eq(78)
    end
    it "should set the night temperatures to be lows" do
      expect(forecast[0][:low]).to eq(60)
      expect(forecast[1][:low]).to eq(64)
    end
    it "should set day and night details" do
      expect(forecast[0][:day_details]).to eq("Sunny, with a high near 75. East wind 5 to 10 mph.")
      expect(forecast[0][:night_details]).to eq("Clear, with a low around 60. East wind around 5 mph, with gusts as high as 10 mph.")
      expect(forecast[-1][:day_details]).to eq("Mostly sunny, with a high near 72.")
    end
    it "should correctly set day and night recorded" do
      expect(forecast[0][:day_recorded]).to be true
      expect(forecast[0][:night_recorded]).to be true
      expect(forecast[-1][:day_recorded]).to be true
      expect(forecast[-1][:night_recorded]).to be false
    end
    it "should not set low or night details for non-existant nights" do
      expect(forecast[-1][:low]).to be nil
      expect(forecast[-1][:night_details]).to be nil
    end
  end
end

