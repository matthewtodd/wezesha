Feature: Administrator Credits Account
  In order to use Wezesha from MoshiLife without paying myself
  As an Administrator
  I want to give credit to an Account

  Scenario: Create Credit from the API
    Given the acme account balance is 10 dollars
    When I use the Admin API to credit acme 5 dollars
    Then I should receive a Created status
    And the acme account balance should be 15 dollars
