Feature: Book List
Users should be able to list books and browse the list of available books. 
Admins should be able to remove books as they see fit.

    # Generic book list search
    Scenario: User looks for books
    Given there are books in the database
    When a user searches for books
    Then books should be listed

    # Filtered book list search
    Scenario: User looks for books with filters
    Given the user has enabled search filters
    And there are books in the database
    When a user searches for books
    Then the books matching the filters should be listed
    But the books not matching the filters should not be listed

    # Add books to the list
    Scenario: User adds book to the list
    When the user puts a book up for rent
    Then the book should be added to the list

    # Remove books from list (admin)
    Scenario: Admin removes book from the list
    When an admin removes a book from the list
    Then the book should be unlisted
    And the user that put it up should be notified that the book has been removed

    # Remove books from list (user)
    Scenario: User removes book from the list
    Given that a book was placed on the list by a user
    When a user removes the book
    Then the book should be unlisted 

    # Remove books from list (rented)
    Scenario: Book is rented
    When a book is marked as rented
    Then the book should be unlisted

    # Go to book page
    Scenario: User wants to see book page
    When a user clicks a book icon on the list
    Then the book page should appear