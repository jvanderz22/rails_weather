describe HourCrawler do
  let(:hour_crawler) { HourCrawler.new }
  describe "#forecast" do
    before(:each) do
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
      expect(@forecast[0][:hour]).to eq("2:00 PM")
      expect(@forecast[1][:hour]).to eq("3:00 PM")
      expect(@forecast[10][:hour]).to eq("12:00 AM")
      expect(@forecast[23][:hour]).to eq("1:00 PM")
    end
    it "should correctly find temperature" do
      expect(@forecast[0][:temperature]).to eq(72)
      expect(@forecast[1][:temperature]).to eq(72)
      expect(@forecast[23][:temperature]).to eq(76)
    end
    it "should correctly find precipation percentage" do
      expect(@forecast[0][:precipitation]).to eq(0.0)
      expect(@forecast[23][:precipitation]).to eq(0.13)
    end
    it "should correctly find humidity percentage" do
      expect(@forecast[0][:humidity]).to eq(0.57)
      expect(@forecast[1][:humidity]).to eq(0.55)
      expect(@forecast[23][:humidity]).to eq(0.56)
    end
    it "should correctly find sky cover percentage" do
      expect(@forecast[0][:sky_cover]).to eq(0.16)
      expect(@forecast[1][:sky_cover]).to eq(0.17)
      expect(@forecast[23][:sky_cover]).to eq(0.59)
    end
    it "should correctly find wind speed" do
      expect(@forecast[0][:wind]).to eq(7)
      expect(@forecast[1][:wind]).to eq(8)
      expect(@forecast[23][:wind]).to eq(9)
    end
  end
end
