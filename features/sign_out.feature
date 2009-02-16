Feature: Sign Out
  In order to keep other people from accidentally accessing my account
  as a developer
  I want to sign out of my account
  
  Scenario: Sign Out
    Given these accounts
    | subdomain    | email                 | password    |
    | my-subdomain | developer@example.com | my-password |
    And I am signed in to my-subdomain as developer@example.com
    And I am on the account page for my-subdomain
    When I follow "Sign Out"
    Then I should see "Sign In"
