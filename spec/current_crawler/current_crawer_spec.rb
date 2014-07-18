describe CurrentCrawler do
  #comparing with sample web page at spec/files/national_weather_service.html
  let(:current_crawler) { CurrentCrawler.new }
  let(:forecast) { current_crawler.forecast }
  describe "#forecast" do
    it "expects the forecast as a hash" do
      expect(forecast).to be_kind_of(Hash)
    end
    it "expects to properly read in :condition" do
      expect(forecast[:condition]).to eq("Partly Cloudy")
    end
    it "expects to properly read in :temperature" do
      expect(forecast[:temperature]).to eq(73)
    end
    it "expects to properly read in :humidity" do
      expect(forecast[:humidity]).to eq(57)
    end
    it "expects to properly read in :wind_speed" do
      expect(forecast[:wind_speed]).to eq("Vrbl 3 mph")
    end
  end
end
