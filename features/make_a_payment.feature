Feature: Make a Payment
  In order to send messages that cost money
  As a developer
  I want to be able to make a payment for my account

  Scenario: Web UI
    Given the acme account has 2 dollars in it
    And I am signed in to acme as developer@acme.example.com
    And I am on the new payment page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal notifies the site about my payment
    Then the acme account should have 12 dollars in it

  Scenario: Web UI -- Unacknowledged Paypal Notification
    Given the acme account has 2 dollars in it
    And I am signed in to acme as developer@acme.example.com
    And I am on the new payment page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal notifies the site about my unacknowledged payment
    Then the acme account should have 2 dollars in it

  Scenario: Web UI -- Invalid Paypal Notification
    Given the acme account has 2 dollars in it
    And I am signed in to acme as developer@acme.example.com
    And I am on the new payment page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal incorrectly notifies the site about my payment
    Then the acme account should have 2 dollars in it
