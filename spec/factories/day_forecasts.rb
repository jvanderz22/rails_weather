# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day_forecast do
    day "MyString"
    temperature 1
    temperature_type "MyString"
  end
end
