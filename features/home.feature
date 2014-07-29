Feature: Home Page

  As a user
  I want to visit the website
  So that I can see the weather

  Scenario: There are current conditions
    Given I can connect to the internet
    And I visit the home page
    Then I should see "Current Conditions"

  Scenario: There are working links to other pages
    Given I can connect to the internet
    And I visit the home page
    # Then "Sign Up" should be a link to "/sign_up"
    #And "Sign In" should be a link to "/sign_in"
    And "Hourly Forecast" should be a link to "/hourly_forecast"
    And "Daily Forecast" should be a link to "/daily_forecast"

  Scenario: The current conditions are accurate
    Given I can connect to the internet
    And I visit the home page
    Then I should see "Temperature:"
    And I should see "Conditions:"
    And I should see "Humidity:"
    And I should see "Wind Speed:"
