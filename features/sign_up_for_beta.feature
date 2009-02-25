Feature: Sign Up for Beta Program
  In order to gain early access to the website
  As a developer
  I want to request an invitation code

  Scenario: Subscription
    Given I am on the home page
    When I fill in "Email" with "developer@example.com"
    And I press "Subscribe"
    Then I should see "Thank You"

  Scenario: Invalid Subscription
    Given I am on the home page
    When I press "Subscribe"
    Then I should not see "Thank You"
