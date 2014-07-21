# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hour_forecast do
    time Time.now
    temperature 100
    wind 20
    precipitation 0.80
    humidity 0.85
    sky_cover 0.96
  end
end
