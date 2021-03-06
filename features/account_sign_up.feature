Feature: Sign Up
  In order to begin using the system
  As a developer
  I want to sign up for an account
  
  Scenario: Successful Sign Up
    Given I am on the sign up page
    When I fill in "Invitation Code" with "sample"
    And I fill in "Subdomain" with "subdomain"
    And I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Sign Up"
    Then I should see "Sign In"
    And I should see "developer@example.com"

  Scenario: Failed Sign Up
    Given I am on the sign up page
    When I fill in "Invitation Code" with "sample"
    And I fill in "Subdomain" with "subdomain"
    And I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with ""
    And I press "Sign Up"
    Then I should see "doesn't match"

  Scenario: Duplicate Sign Up
    Given I am on the sign up page
    And someone has already signed up with Invitation Code "sample"
    When I fill in "Invitation Code" with "sample"
    And I fill in "Subdomain" with "subdomain"
    And I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Sign Up"
    Then I should see "has already been taken"
