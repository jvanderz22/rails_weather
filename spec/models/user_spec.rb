require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  describe "phone_number" do
    it "is valid if a phone number isn't entered" do
      expect(build(:user, phone_number: nil)).to be_valid
    end

    it "is valid if a valid phone number is entered" do
      expect(build(:user, phone_number: "616-514-9790")).to be_valid
      expect(build(:user, phone_number: "(616)514-9790")).to be_valid
      expect(build(:user, phone_number: "6165149790")).to be_valid
    end

    it "is not valid with an improperly formatted phone number" do
      expect(build(:user, phone_number: "616-514-979")).to_not be_valid
      expect(build(:user, phone_number: "616514979")).to_not be_valid
      expect(build(:user, phone_number: "abcdefghij")).to_not be_valid
      expect(build(:user, phone_number: "abc-def-ghif")).to_not be_valid
    end
  end

  describe "zip" do
    it "is not valid without a 5 digit zip code" do
      expect(build(:user, zip: "abcde")).to be_invalid
      expect(build(:user, zip: "1234")).to be_invalid
      expect(build(:user, zip: "123456")).to be_invalid
    end

    it "is valid with a five digit zip code" do
      expect(build(:user, zip: "12345")).to be_valid
    end
  end

  it "is not valid without a send_text field" do
    expect(build(:user, send_text: nil)).to be_invalid
  end

  it "is not valid without a send_email field" do
    expect(build(:user, send_email: nil)).to be_invalid
  end

  it "is valid if send_text is false" do
    expect(build(:user, send_text: false)).to be_valid
  end

  it "is valid if send_email is false" do
    expect(build(:user, send_email: false)).to be_valid
  end

  describe ".users_with_emails" do
    it "returns all users in the database that want to be sent emails" do
      users_with_emails = (0..2).map do
        create(:user)
      end
      users_without_emails = (0..2).map do
        create(:user, send_email: false)
      end
      expect(User.users_with_emails).to eq(users_with_emails)
    end
  end
end
