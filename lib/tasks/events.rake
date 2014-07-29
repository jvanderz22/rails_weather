require 'hour_crawler'
require 'day_crawler'
require 'current_crawler'

namespace :events do
  desc "Send forecast emails to all subscribed users"
  task email_forecast: :environment do
    ForecastEmailHelper.email_users
  end
end
