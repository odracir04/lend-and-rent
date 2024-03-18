Feature: User Profile
Each user has a profile with its own page and details. This enables them to rent books.
    
    Scenario: User wants to see a profile
    When a user opens a profile page
    Then the information of that user should appear

    Scenario: User wants to edit his profile
    Given that a user is logged in
    When the user opens his profile page
    Then he should be able to edit his information

    Scenario: User wants to see his rented books
    Given that a user is logged in
    When the user opens his profile page
    Then the list of books he rented should appear

    Scenario: User wants to delete profile
    Given that a user is logged in
    When the user deletes his profile
    Then the profile page should disappear

    Scenario: Admin wants to delete profile
    Given that an admin is logged in
    When an admin deletes a profile
    Then the profile page should disappear

    Scenario: User creates profile
    When a user signs up
    Then his profile page should be created