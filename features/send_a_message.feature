Feature: Send a Message
  In order to get important information to one of my own users
  As a developer
  I want to send a message to their phone

  Scenario: Web UI
    Given the acme account has 2 dollars in it
    And I am signed in to acme as developer@acme.example.com
    And I am on the account page for acme
    When I follow "New Message"
    And I fill in "Recipient" with some phone number
    And I fill in "Text" with "Hi, I'm testing out the system."
    And I press "Send"
    Then the message "Hi, I'm testing out the system." should be delivered to some phone number
    And the acme account should have less than 2 dollars in it

  Scenario: Web UI Localization
    Given I am signed in to acme as developer@acme.example.com
    And I am on the new message page for acme
    When I follow "Kiswahili"
    Then I should not see "translation missing"
  
  Scenario: API
    Given the acme account has 2 dollars in it
    When I use the API to send "Hi, I'm testing out the Active Resource API." to some phone number
    Then I should receive a Created status

  Scenario: API Authentication Required
    Given the acme account has 2 dollars in it
    When I use the API without my credentials to send "Hi, I'm testing out the Active Resource API." to some phone number
    Then I should receive an Unauthorized error

  Scenario: API Invalid
    Given the acme account has 2 dollars in it
    When I use the API to send "" to some phone number
    Then I should receive an Unprocessable Entity error
