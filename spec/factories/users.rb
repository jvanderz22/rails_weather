# Read about factories at https://github.com/thoughtbot/factory_girl


FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    zip "49544"
    phone_number "616-514-5555"
    send_email true
    send_text true
  end
end
