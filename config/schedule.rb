set :environment, 'development'
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '6:00 am'  do
  rake "events:email_users"
end

