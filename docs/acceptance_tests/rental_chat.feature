Feature: Rental Chat
In order to rent books, users will be able to chat with each other
to schedule dates and times for delivery

    Scenario: User closes chat
    When the user clicks the close button
    Then the chat should close

    Scenario: User writes message
    When the user writes a message
    And the user clicks the send button
    Then the message should be sent
    And the message should appear on screen

    Scenario: Conversation on screen
    Given messages have been sent
    When the chat is opened
    Then messages should appear on screen
