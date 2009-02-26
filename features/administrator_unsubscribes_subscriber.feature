Feature: Administrator Unsubscriber Subscriber
  In order to remove duplicate subscribers and keep out the riff raff
  As an Administrator
  I want to unsubscribe a Subscriber
  
  Scenario: Unsubscribe Subscriber
    Given I am signed in as an administrator
    And I am on the administrative subscribers page
    When I follow "Unsubscribe" for existing subscriber "subscriber@example.com"
    Then I should not see "subscriber@example.com"
