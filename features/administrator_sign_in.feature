Feature: Administrator Sign In
  In order to do things to other people's accounts
  As an administrator
  I want to sign in

  Scenario: Successful Sign In
    Given I am on the administrative sign in page
    When I fill in "Email" with "administrator@example.com"
    And I fill in "Password" with "secret"
    And I press "Sign In"
    Then I should see "Welcome"
  
  Scenario: Failed Sign In
    Given I am on the administrative sign in page
    When I fill in "Email" with "administrator@example.com"
    And I fill in "Password" with "incorrect password"
    And I press "Sign In"
    Then I should see "is invalid"
