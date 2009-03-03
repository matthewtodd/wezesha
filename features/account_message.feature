Feature: Send a Message
  In order to get important information to one of my own users
  As a developer
  I want to send a message to their phone

  Scenario: Web UI
    Given I am signed in to acme as developer@acme.example.com
    And I have made a payment for 2 dollars
    And I am on the new text message page for acme
    When I fill in "Recipient" with some phone number
    And I fill in "Text" with "Hi, I'm testing out the system."
    And I press "Send"
    Then the message "Hi, I'm testing out the system." should be delivered to some phone number
    And the acme account should have less than 2 dollars in it

  Scenario: API
    Given I have made a payment for 2 dollars
    When I use the API to send "Hi, I'm testing out the Active Resource API." to some phone number
    Then I should receive a Created status

  Scenario: API Authentication Required
    Given I have made a payment for 2 dollars
    When I use the API without my credentials to send "Hi, I'm testing out the Active Resource API." to some phone number
    Then I should receive an Unauthorized error

  Scenario: API Invalid
    Given I have made a payment for 2 dollars
    When I use the API to send "" to some phone number
    Then I should receive an Unprocessable Entity error

  Scenario: API Insufficient Funds
    Given I have not made any payments
    When I use the API to send "Hi, I'm testing out the Active Resource API." to some phone number
    Then I should receive an Unprocessable Entity error
