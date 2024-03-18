Feature: Book page

    Scenario: User opens book page
    When a user opens a book page
    Then the book details should appear
    And the user renting the book should appear
    And the comments should appear

    Scenario: User creates book page
    Given a user is logged in
    When the user puts a book up for rent
    Then the book page should be created

    Scenario: User removes book
    Given a user is logged in
    When the user removes a book
    Then the book page should be deleted

    Scenario: Admin removes book
    Given an admin is logged in 
    When the admin removes a book
    Then the book page should be deleted

    Scenario: User clicks renter icon
    When a user clicks the renter icon
    Then the renter's profile page should open

    Scenario: User wants to rent book
    When a user clicks rent book
    Then a chat with the rented should be created
    And the chat should open

    Scenario: User comments on book
    When a user writes a comment
    And clicks the comment button
    Then the comment should be sent
    