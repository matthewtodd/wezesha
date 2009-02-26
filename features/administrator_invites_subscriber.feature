Feature: Administrator Invites Subscriber
  In order to let interested people into the system slowly
  As an Administrator
  I want to send an Invitation to a Subscriber

  Scenario: New Invitation
    Given I am signed in as an administrator
    And I am on the administrative subscribers page
    When I follow "Invite" for existing subscriber "subscriber@example.com"
    Then existing subscriber "subscriber@example.com" should have 1 Invitation
    And an email should be sent to "subscriber@example.com"
    