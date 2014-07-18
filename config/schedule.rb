set :environment, 'development'
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '11:14 am'  do
  rake "events:hour_scraper", :environment => 'development'
end

every 1.day, :at => '12:52 pm' do
  rake "events:day_scraper"
end
