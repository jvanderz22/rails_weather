Feature: Edit Account

  As a website user
  I want to edit my acoount
  So that I change my preferences

  Scenario: There is a link to the edit_profile page
    Given I am signed in
    Then "Edit account" should be a link to "/users/edit"

  Scenario: The edit profile page allows for changes to be made to the account
    Given I am signed in
    And I visit "/users/edit"
    Then I should see "Email"
    And I should see "Password"
    And I should see "Password confirmation"
    And I should see "Send email"
    And I should see "Send text"
    And I should see "Current password"

  Scenario: I can update my preferences
    Given I am signed in with password "12345678" and registered for emails and texts
    And I visit "/users/edit"
    When I uncheck "user send email"
    And I enter "12345678" as my "user current password"
    And I press "Update"
    And I visit "/users/edit"
    Then the checkbox "user send email" is unchecked
    And the checkbox "user send text" is checked
