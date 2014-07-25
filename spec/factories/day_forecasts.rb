# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day_forecast do
    day "Wednesday"
    high 80
    low 50
    day_details "Day details"
    night_details "Night details"
    day_recorded true
    night_recorded true
  end
end
