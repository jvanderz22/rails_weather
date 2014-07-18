# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hour_forecast do
    date "2014-07-16"
    hour "2014-07-16 16:17:17"
    temperature 1
    wind 1
    precipitation "9.99"
    humidity "9.99"
    sky_cover "9.99"
  end
end
