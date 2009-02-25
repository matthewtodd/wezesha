Feature: Sign Out
  In order to keep other people from accidentally accessing my account
  As a developer
  I want to sign out of my account
  
  Scenario: Sign Out
    Given I am signed in to acme as developer@acme.example.com
    And I am on the account page for acme
    When I follow "Sign Out"
    Then I should see "Sign In"
