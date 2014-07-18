# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :current_forecast do
    time "2014-07-17 17:15:46"
    temperature 1
    condition "MyString"
    wind_speed "MyString"
    humidity 1
  end
end
