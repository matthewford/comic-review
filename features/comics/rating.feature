Feature: comics/rating
  To rate a comment 
  A user should comment on a comic with a rating

  Scenario: rate a comic
    Given a comic named "XKCD"
    And I login as Matt
    When I view the "xkcd" comic page
    Then I should see "Add Your Comment"
    When I fill in "Comment" with "This Rocks!"
    And I choose "rating2"
    And I press "Create"
    Then I should see a success message
    And I should see "This Rocks!"
    And I should see some stars