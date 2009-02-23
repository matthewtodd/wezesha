Feature: Buy Credit
  In order to send messages that cost money
  As a developer
  I want to be able to buy credit for my account

  Scenario: Web UI
    Given the acme account has 2 dollars in it
    And I am signed in to acme as developer@acme.example.com
    And I am on the new payment page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal later notifies the site about my payment
    Then the acme account should have 12 dollars in it
