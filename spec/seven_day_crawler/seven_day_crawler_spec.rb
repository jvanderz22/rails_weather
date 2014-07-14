describe SevenDayCrawler do
  #comparing with sample web page at spec/files/nation_weather_service.html
  let (:seven_day_crawler) { SevenDayCrawler.new }
  let (:forecast) { seven_day_crawler.forecast }
  describe "#forecast" do
    it "expects the forecast as an array of hashes" do
      expect(forecast).to be_kind_of(Array)
      expect(forecast[0]).to be_kind_of(Hash)
    end
    it "expects each hash to have a :day" do
      expect(forecast[0]).to have_key(:day)
    end
    it "expects each hashed item to have a :temp_type" do
      expect(forecast[0]).to have_key(:temp_type)
    end
    it "expect each hashed item to have a :temp" do
      expect(forecast[0]).to have_key(:temp)
    end
    it "expects the array to be in order from present day to subsequent future dates" do
      #"Today" is thursday in example HTML file
      expect(forecast[0][:day]).to eq("Today")
      expect(forecast[1][:day]).to eq("Tonight")
      expect(forecast[2][:day]).to eq("Friday")
      expect(forecast[-1][:day]).to eq("Wednesday")
    end
    it "expects nights to be included in the array" do
      expect(forecast[1][:day]).to eq("Tonight")
      expect(forecast[3][:day]).to eq("Friday Night")
    end
    it "should remove html formatting from the values" do
      expect(!!(forecast[0][:day] =~ /<(.*)>/)).to be false
    end
    it "should have temp_type of 'High' for days" do
      expect(forecast[0][:temp_type]).to eq("High")
    end
    it "should have temp_type of 'Low' for nights" do
      expect(forecast[1][:temp_type]).to eq("Low")
    end
    it "should parse the temperature correctly" do
      expect(forecast[0][:temp]).to eq(75)
      expect(forecast[1][:temp]).to eq(60)
    end
  end
end
