Feature: Administrator Unsubscribes Subscriber
  In order to remove duplicate subscribers and keep out the riff raff
  As an Administrator
  I want to unsubscribe a Subscriber
  
  Scenario: Unsubscribe Subscriber
    When I use the Admin API to delete existing subscriber "subscriber@example.com"
    Then I should receive an OK status
    And existing subscriber "subscriber@example.com" should no longer exist
