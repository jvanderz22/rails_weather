require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET 'home'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

end
