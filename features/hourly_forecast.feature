Feature: Hourly Forecast Page

  As a user
  I want to vist the hourly forecast page
  So that I can see the weather for the next 24 hours

  Scenario: The page is described as "Hourly Forecast"
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Hourly Forecast"

  Scenario: The page has a 24 hour forecast
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "12 PM"
    And I should see "6 PM"
    And I should see "12 AM"
    And I should see "6 AM"
    And I should see "11 AM"

  Scenario: The page has precipitation info
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Precipitation Percentage"

  Scenario: The page has temperature info
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Temperature"

  Scenario: The page has humidity info
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Humidity"

  Scenario: The page has wind speed info
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Wind Speed"

  Scenario: The page has cloud cover info
    Given I can connect to the internet
    And I visit "/hourly_forecast"
    Then I should see "Cloud Cover Percentage"
