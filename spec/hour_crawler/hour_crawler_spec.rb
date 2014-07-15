describe HourCrawler do
  let(:hour_crawler) { HourCrawler.new }
  describe "#forecast" do
    before(:each) do
      hour_crawler.create_forecast
      @forecast = hour_crawler.forecast
    end
    it "should return an array with each hour as a hash" do
      expect(@forecast).to be_instance_of(Array)
      expect(@forecast[0]).to be_instance_of(Hash)
    end
    it "returns 24 hour hashes" do
      expect(@forecast.length).to eq(24)
    end
    it "should correctly set the date" do
      expect(@forecast[0][:date]).to eq("07/10/2014")
      expect(@forecast[1][:date]).to eq("07/10/2014")
      expect(@forecast[10][:date]).to eq("07/11/2014")
      expect(@forecast[23][:date]).to eq("07/11/2014")
    end
    it "should correct set the time" do
      expect(@forecast[0][:time]).to eq("2 PM")
      expect(@forecast[1][:time]).to eq("3 PM")
      expect(@forecast[10][:time]).to eq("12 AM")
      expect(@forecast[23][:time]).to eq("1 PM")
    end
    it "should correctly find temperature" do
      expect(@forecast[0][:temp]).to eq(72)
      expect(@forecast[1][:temp]).to eq(72)
      expect(@forecast[23][:temp]).to eq(76)
    end
    it "should correctly find precipation percentage" do
      expect(@forecast[0][:precip]).to eq("0%")
      expect(@forecast[23][:precip]).to eq("13%")
    end
    it "should correctly find humidity percentage" do
      expect(@forecast[0][:humidity]).to eq("57%")
      expect(@forecast[1][:humidity]).to eq("55%")
      expect(@forecast[23][:humidity]).to eq("56%")
    end
    it "should correctly find sky cover percentage" do
      expect(@forecast[0][:sky_cover]).to eq("16%")
      expect(@forecast[1][:sky_cover]).to eq("17%")
      expect(@forecast[23][:sky_cover]).to eq("59%")
    end
    it "should correctly find wind speed" do
      expect(@forecast[0][:wind]).to eq(7)
      expect(@forecast[1][:wind]).to eq(8)
      expect(@forecast[23][:wind]).to eq(9)
    end
  end
end
