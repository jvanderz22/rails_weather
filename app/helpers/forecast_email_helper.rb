module ForecastEmailHelper

  class EmailUsers
    def email_users
      @forecast = nil
      users.each do |user|
        ForecastMailer.send_forecast(user, forecast).deliver
      end
    end

    private

    def users
      User.users_with_emails
    end

    def forecast
      @forecast ||= DayForecast.today
    end
  end

  def self.email_users
    email_users = EmailUsers.new
    email_users.email_users
  end

end
