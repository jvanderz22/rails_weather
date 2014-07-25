Feature: Daily Forecast Page

  As a user
  I want to visit the daily forecast page
  So that I can see the weather for the next 7 days

  Scenario: The page is described as "Daily Forecast"
    Given I can connect to the internet
    And I visit "/daily_forecast"
    Then I should see "Daily Forecast"

  Scenario: The page has a 7 day forecast
    Given I connect to the internet on Thursday
    And I visit "/daily_forecast"
    Then I should see "Today"
    And I should see "Friday"
    And I should see "Saturday"
    And I should see "Sunday"
    And I should see "Monday"
    And I should see "Tuesday"
    And I should see "Wednesday"
    And I should see "High:" "7" times
    And I should see "Low:" "6" times
    And I should see "Day Forecast:" "7" times
    And I should see "Night Forecast:" "6" times

  Scenario: The page has a 7 day forecast for night
    Given I connect to the internet on Tuesday Night
    And I visit "/daily_forecast"
    Then I should see "Today"
    And I should see "Wednesday"
    And I should see "Thursday"
    And I should see "Tuesday"
    And I should see "High:" "7" times
    And I should see "Low:" "7" times
    And I should see "Day Forecast:" "7" times
    And I should see "Night Forecast:" "7" times

  Scenario: The page has weather information
    Given I can connect to the internet
    And I visit "/daily_forecast"
    Then I should see "Day Forecast: Sunny, with a high near 75. East wind 5 to 10 mph."
    And I should see "High: 75"
    And I should see "Low: 60"

