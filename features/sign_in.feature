Feature: Sign In
  In order to access my account
  as a developer
  I want to sign in to my account
  
  Scenario: Successful Sign In
    Given these accounts
    | subdomain    | email                 | password    |
    | my-subdomain | developer@example.com | my-password |
    And I am on the sign in page for my-subdomain
    When I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "my-password"
    And I press "Sign In"
    Then I should see "Welcome"

  Scenario: Failed Sign In
    Given these accounts
    | subdomain    | email                 | password    |
    | my-subdomain | developer@example.com | my-password |
    And I am on the sign in page for my-subdomain
    When I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "not-my-password"
    And I press "Sign In"
    Then I should see "is not valid"

  Scenario: Localized Sign In
    Given these accounts
    | subdomain    | email                 | password    |
    | my-subdomain | developer@example.com | my-password |
    And I am on the sign in page for my-subdomain
    When I follow "Kiswahili"
    Then I should not see "translation missing"
    
  Scenario: Sign In Required
    Given these accounts
    | subdomain    | email                 | password    |
    | my-subdomain | developer@example.com | my-password |
    And I have not signed in
    When I go to the account page for my-subdomain
    Then I should see "Sign In"
