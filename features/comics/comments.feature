Feature: comics/comments
  To leave feedback on a comic
  A User can comment a comic

  Scenario: Creating a comment
    Given a comic named "XKCD"
    And I login as Matt
    When I view the "xkcd" comic page
    Then I should see "Add Your Comment"
    When I fill in "Comment" with "This Rocks!"
    And I press "Create"
    Then I should see a success message
    And I should see "This Rocks!"

