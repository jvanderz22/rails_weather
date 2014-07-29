Feature: Sign up

  As a website user
  I want to create an account
  So I can set my preferences

  Scenario: There is a link to the sign_up page
    Given I can connect to the internet
    And I visit the home page
    Then "Sign up" should be a link to "/users/sign_up"

  Scenario: I can successfully sign up
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "12345678" as my "user password"
    And I enter "12345678" as my "user password confirmation"
    And I enter "12345" as my "user zip"
    And I enter "(616)514-9790" as my "user phone number"
    And I press "Sign Up"
    Then I should see "Signed in as email@email.com"

  Scenario: I must enter a valid email address
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email" as my "user email"
    And I enter "12345678" as my "user password"
    And I enter "12345678" as my "user password confirmation"
    And I enter "12345" as my "user zip"
    And I enter "(616)514-9790" as my "user phone number"
    And I press "Sign Up"
    Then I should not be signed in

  Scenario: I must enter a long enough password
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "123456" as my "user password"
    And I enter "123456" as my "user password confirmation"
    And I press "Sign Up"
    Then I should see "Password is too short"

  Scenario: I must match the passwords
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "12345678" as my "user password"
    And I enter "123456789" as my "user password confirmation"
    And I press "Sign Up"
    Then I should see "Password confirmation doesn't match"

  Scenario: I must enter a zip code
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I press "Sign Up"
    Then I should see "Zip can't be blank"

  Scenario: I must enter 5 digits as my zip
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "1234" as my "user zip"
    And I press "Sign Up"
    Then I should see "Zip must be 5 digit number"

  Scenario: I can sign up without a phone number
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "12345678" as my "user password"
    And I enter "12345678" as my "user password confirmation"
    And I enter "12345" as my "user zip"
    And I press "Sign Up"
    Then I should see "Signed in as email@email.com"

  Scenario: If I give a phone number, it must be valid
    Given I can connect to the internet
    And I visit "/users/sign_up"
    When I enter "email@email.com" as my "user email"
    And I enter "12345678" as my "user password"
    And I enter "12345678" as my "user password confirmation"
    And I enter "12345" as my "user zip"
    And I enter "616-121-121" as my "user phone number"
    And I press "Sign Up"
    Then I should see "Phone number isn't valid"
