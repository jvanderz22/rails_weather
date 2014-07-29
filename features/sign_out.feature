Feature: Sign out

  As a website user
  I want to sign out of my account
  So that I am no longer signed in

  Scenario: I can sign out
    Given I am signed in
    When I press "Sign out"
    Then I should not be signed in
