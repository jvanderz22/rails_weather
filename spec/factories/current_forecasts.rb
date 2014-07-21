# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :current_forecast do
    temperature 100
    condition "Sunny"
    wind_speed "E 3 mph"
    humidity 0.56
  end
end
