class ForecastMailer < ActionMailer::Base
  default from: "jordan@rails_weather.com"

  def welcome_email(user)
    @user = user
    @url = "rails_weather.com"
    mail(to: @user.email, subject: "Welcome!")
  end

  def send_forecast(user, forecast)
    @user = user
    @forecast = forecast
    mail(to: @user.email, subject: "Today's Forecast")
  end
end
