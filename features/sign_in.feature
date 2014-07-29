Feature: Sign In

  As a website user
  I want to sign into an account
  So that I can change my information

  Scenario: There is a link to the sign_in page
    Given I can connect to the internet
    And I visit the home page
    Then "Sign in" should be a link to "/users/sign_in"

  Scenario: I can successfully sign in
    Given I am signed up as email@email.com with password 12345678
    And I am signed out
    And I visit "/users/sign_in"
    When I enter "email@email.com" as my "user email"
    And I enter "12345678" as my "user password"
    And I press "Sign In"
    Then I should see "Signed in as email@email.com"

  Scenario: I can't sign in with the wrong password
    Given I am signed up as email@email.com with password 12345678
    And I am signed out
    And I visit "/users/sign_in"
    When I enter "email@email.com" as my "user email"
    And I enter "1234567" as my "user password"
    And I press "Sign In"
    Then I should not be signed in

