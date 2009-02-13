Feature: Sign Up
  In order to begin using the system
  as a developer
  I want to sign up for an account
  
  Scenario: Successful Sign Up
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Subdomain" with "subdomain"
    And I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Sign Up"
    Then I should see "Sign In"

  Scenario: Failed Sign Up
    Given I am on the sign up page
    When I fill in "Subdomain" with "subdomain"
    And I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with ""
    And I press "Sign Up"
    Then I should see "doesn't match"

  Scenario: Localized Sign Up
    Given I am on the sign up page
    When I follow "Kiswahili"
    Then I should not see "translation missing"
