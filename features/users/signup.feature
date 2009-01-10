Feature: users/signup
  To sign up to the application
  A potential user of the application
  Must signup

  Scenario Outline: Successful signup
    When I go to /signup
    And I fill in "Username" with "<name>"
    And I fill in "Email" with "<mail>"
    And I fill in "Password" with "<password>"
    And I fill in "Password Confirmation" with "<password>"
    And I press "Sign Up"
    Then I should see "Welcome to ComicReview"
    And I should see a success message
    
    Examples:
      | name        | mail           | password    |
      | tester      | test@test.com  | testing     |
