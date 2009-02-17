Feature: Sign In
  In order to access my account
  As a developer
  I want to sign in to my account
  
  Scenario: Successful Sign In
    Given I am on the sign in page for acme
    When I fill in "Email" with "developer@acme.example.com"
    And I fill in "Password" with "secret"
    And I press "Sign In"
    Then I should see "Welcome"
  
  Scenario: Failed Sign In
    Given I am on the sign in page for acme
    When I fill in "Email" with "developer@acme.example.com"
    And I fill in "Password" with "incorrect password"
    And I press "Sign In"
    Then I should see "is invalid"

  Scenario: Localized Sign In
    Given I am on the sign in page for acme
    When I follow "Kiswahili"
    Then I should not see "translation missing"
    
  Scenario: Sign In Required
    Given I am on the account page for acme
    Then I should see "Sign In"
    
  Scenario: Sign In Redirect To Originally Requested Page
