Feature: Test Messages
  In order to begin learning how to use the system
  As a developer
  I want to send a test message to my phone

  Scenario: Through the Web UI
    Given I am signed in to acme as developer@acme.example.com
    And I have configured my phone number
    And I am on the account page for acme
    When I follow "New Message"
    And I fill in "Text" with "Hi, I'm testing out the system."
    And I press "Send"
    Then I should receive "Hi, I'm testing out the system." on my phone

  Scenario: Web UI Localization
    Given I am signed in to acme as developer@acme.example.com
    And I have configured my phone number
    And I am on the account page for acme
    When I follow "New Message"
    And I follow "Kiswahili"
    Then I should not see "translation missing"
