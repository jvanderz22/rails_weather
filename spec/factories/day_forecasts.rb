# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day_forecast do
    day "Wednesday"
    temperature 50
    temperature_type "High"
  end
end
