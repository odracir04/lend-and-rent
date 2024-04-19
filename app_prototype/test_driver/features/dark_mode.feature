Feature: Dark mode
  The app should alternate between dark and light mode by pressing a button

  Scenario Outline: Switch to dark mode
    Given I am in <mode> mode
    When I tap the "dark_mode_button" button
    Then I am in <new> mode
    Examples:
    | mode | new |
    | "dark" | "light" |
    | "light" | "dark" |