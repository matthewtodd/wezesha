Feature: Send a Test Message
  In order to begin learning how to use the system
  As a developer
  I want to send a test message to my phone

  Scenario: Web UI
    Given I am signed in to acme as developer@acme.example.com
    And I have configured my phone number
    And I am on the account page for acme
    When I follow "New Message"
    And I fill in "Recipient" with my phone number
    And I fill in "Text" with "Hi, I'm testing out the system."
    And I press "Send"
    Then I should receive "Hi, I'm testing out the system." on my phone
    And my account balance should not change

  Scenario: Web UI Localization
    Given I am signed in to acme as developer@acme.example.com
    And I have configured my phone number
    And I am on the account page for acme
    When I follow "New Message"
    And I follow "Kiswahili"
    Then I should not see "translation missing"
  
  Scenario: API
    Given I have configured my phone number
    When I use the API to send a message to my phone number with text "Hi, I'm testing out the Active Resource API."
    Then I should receive a Created status
    And I should receive "Hi, I'm testing out the Active Resource API." on my phone
    And my account balance should not change

  Scenario: API Authentication Required
    Given I have configured my phone number
    When I use the API without my credentials to send a message to my phone number with text "Hi, I'm testing out the Active Resource API."
    Then I should receive an Unauthorized error
    And I should not receive "Hi, I'm testing out the Active Resource API." on my phone

  Scenario: API Invalid
    Given I have configured my phone number
    When I use the API to send a message to my phone number with text ""
    Then I should receive an Unprocessable Entity error
    And I should not receive "Hi, I'm testing out the Active Resource API." on my phone
