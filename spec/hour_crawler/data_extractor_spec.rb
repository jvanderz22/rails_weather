describe DataExtractor do

  let(:uri) { URI("http://forecast.weather.gov/MapClick.php?lat=41.92354&lon=-87.64915974012911&lg=english&&FcstType=digital") }
  let(:data_extractor) { DataExtractor.new(Nokogiri::HTML(open(uri))) }
  let(:data) { data_extractor.data }
  describe "#data" do
    it "should return a hash" do
      expect(data).to be_instance_of(Hash)
    end
    describe ":date key" do
      before(:each) do
        @date =  data[:date]
      end
      it "should return an array" do
        expect(@date).to be_instance_of(Array)
      end
      it "should return elements in the form of 'xx/xx'" do
        expect(@date[0]).to match(/\d\d\/\d\d/)
      end
    end
    describe ":time key" do
      before(:each) do
        @time = data[:time]
      end
      it "should return an array of times" do
        expect(@time).to be_instance_of(Array)
      end
      it "should return 24 times" do
        expect(@time.length).to eq(24)
      end
      it "should return time in the form of 'xx'" do
        expect(@time[0]).to match(/\d\d/)
      end
    end
    describe ":precip key" do
      before(:each) do
        @precip = data[:precip]
      end
      it "should return an array" do
        expect(@precip).to be_instance_of(Array)
      end
      it "should have length of 24" do
        expect(@precip.length).to eq(24)
      end
      it "should return elements that are either one or two digits" do
        expect(@precip[0]).to match(/(\d|\d\d)/)
      end
    end
    describe ":humidity" do
      before(:each) do
        @humidity = data[:humidity]
      end
      it "should return an array" do
        expect(@humidity).to be_instance_of(Array)
      end
      it "should have length of 24" do
        expect(@humidity.length).to eq(24)
      end
      it "should return elements that are either one or two digits" do
        expect(@humidity[0]).to match(/\d|\d\d/)
      end
    end
    describe ":wind key" do
      before(:each) do
        @wind = data[:wind]
      end
      it "should return an array" do
        expect(@wind).to be_instance_of(Array)
      end
      it "should be of length 24" do
        expect(@wind.length).to eq(24)
      end
      it "should return elements that are one or more digits" do
        expect(@wind[0]).to match(/(\d)+/)
      end
    end
    describe ":sky_cover" do
      before(:each) do
        @sky_cover = data[:sky_cover]
      end
      it "returns an array" do
        expect(@sky_cover).to be_instance_of(Array)
      end
      it "should be of length 24" do
        expect(@sky_cover.length).to eq(24)
      end
      it "should return elements that are either one or two digits" do
        expect(@sky_cover[0]).to match(/(\d)|(\d\d)/)
      end
    end
  end
end
