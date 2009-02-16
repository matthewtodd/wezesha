Feature: Sign In
  In order to access my account
  as a developer
  I want to sign in to my account
  
  Scenario: Successful Sign In
    Given these accounts
    | subdomain   | email                 | password    |
    | mysubdomain | developer@example.com | my-password |
    And I am on the sign in page for mysubdomain
    When I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "my-password"
    And I press "Sign In"
    Then I should see "Welcome"
  
  Scenario: Failed Sign In
    Given these accounts
    | subdomain   | email                 | password    |
    | mysubdomain | developer@example.com | my-password |
    And I am on the sign in page for mysubdomain
    When I fill in "Email" with "developer@example.com"
    And I fill in "Password" with "not-my-password"
    And I press "Sign In"
    Then I should see "is invalid"

  Scenario: Localized Sign In
    Given these accounts
    | subdomain   | email                 | password    |
    | mysubdomain | developer@example.com | my-password |
    And I am on the sign in page for mysubdomain
    When I follow "Kiswahili"
    Then I should not see "translation missing"
    
  Scenario: Sign In Required
    Given these accounts
    | subdomain   | email                 | password    |
    | mysubdomain | developer@example.com | my-password |
    And I have not signed in
    And I am on the account page for mysubdomain
    Then I should see "Sign In"
    
  Scenario: Sign In Redirect To Originally Requested Page
