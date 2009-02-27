Feature: Make a Payment
  In order to send messages that cost money
  As a developer
  I want to be able to make a payment for my account

  Scenario: Web UI
    Given I am signed in to acme as developer@acme.example.com
    And I have made a payment for 2 dollars
    And I am on the account page for acme
    When I select "10.00" from "Add"
    And I press "Buy Credit"
    And I submit the PayPal form
    And Paypal notifies the site about my payment
    Then the acme account should have 12 dollars in it

  Scenario: Web UI -- Unacknowledged Paypal Notification
    Given I am signed in to acme as developer@acme.example.com
    And I have made a payment for 2 dollars
    And I am on the account page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal notifies the site about my unacknowledged payment
    Then the acme account should have 2 dollars in it

  Scenario: Web UI -- Invalid Paypal Notification
    Given I am signed in to acme as developer@acme.example.com
    And I have made a payment for 2 dollars
    And I am on the account page for acme
    When I press "Buy Credit"
    And I submit the PayPal form
    And Paypal incorrectly notifies the site about my payment
    Then the acme account should have 2 dollars in it
