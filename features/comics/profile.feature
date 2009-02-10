Feature: comics/profile
  In order to view comic profiles
  A user
  Should be able to search for them

  Scenario: Creating a comic from wikipedia
    Given there is no comic "XKCD"
    Given I login as Matt
    When I search comics for "xkcd"
    Then I should see "Wikipedia Results"
    And I should see "create profile for 'XKCD'"
    When I press "create profile for 'XKCD'"
    Then I should see "XKCD"
    
  Scenario: Searching a comic that does exist
    Given a comic named "XKCD"
    And I login as Matt
    When I search comics for "xkcd"
    Then I should see "Search Results"
    And I should see "XKCD"
    When I follow "XKCD"
    Then I should see "XKCD"
    
  Scenario: Manually creating a comic
    Given I login as Matt
    When I go to /comics/new
    Then I should see "Comic Profile"
    When I fill in "Title" with "Manual Test Comic"
    And I fill in "Description" with "This is *just* testing markdown"
    And I press "Create"
    Then I should see "Manual Test Comic"
    And I should see HTML instead of markdown

  
  
  
