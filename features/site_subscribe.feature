Feature: Subscribe
  In order to receive updates about the website and perhaps get an invitation
  As a developer
  I want to subscribe

  Scenario: New Subscriber
    Given I am on the home page
    When I fill in "Email" with "developer@example.com"
    And I press "Subscribe"
    Then I should see "Thanks"

  Scenario: Invalid New Subscriber
    Given I am on the home page
    When I press "Subscribe"
    Then I should not see "Thanks"
