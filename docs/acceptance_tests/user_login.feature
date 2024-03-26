Feature: User Authentication
Users should be able to register an account and authenticate themselves
to use the app. They should not be allowed to rent books without the 
proper authentication.

    Scenario: User login
    Given a user is registered
    When the user inputs the correct username
    And the user inputs the correct password
    And the user presses login
    Then login should occur

    Scenario: Unregistered user
    Given a user isn't registered
    When the user inputs a username and password
    And the user presses login
    Then login should not occur

    Scenario: Registering user
    When the user presses register
    Then the register page should appear

    Scenario: Wrong credentials
    When the user inputs the wrong username and password
    And the user presses login
    Then login should not occur

    Scenario: Creating account
    Given a user isn't registered
    When the user inputs all his details
    And the user presses register
    Then an account should be created
    And login should occur