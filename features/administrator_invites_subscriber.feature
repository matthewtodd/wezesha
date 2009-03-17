Feature: Administrator Invites Subscriber
  In order to let interested people into the system slowly
  As an Administrator
  I want to send an Invitation to a Subscriber

  Scenario: New Invitation
    Given existing subscriber "subscriber@example.com" has 0 Invitations
    When I use the Admin API to invite existing subscriber "subscriber@example.com"
    Then I should receive a Created status
    And existing subscriber "subscriber@example.com" should have 1 Invitation
    And an email should be sent to "subscriber@example.com"
