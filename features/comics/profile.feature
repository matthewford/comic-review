Feature: comics/profile
  In order to view comic profiles
  A user
  Should be able to search for them

  Scenario: Creating a comic from wikipedia
    Given the comic 'XKCD' is not the database
    And Matt has already signed up
    And I login as Matt
    When I go to /comics?name=xkcd
    Then I should see "Wikipedia Results"
    And I should see "create profile for 'XKCD'"
    When I press "create profile for 'XKCD'"
    Then I should see "XKCD"
    
	Scenario: Searching a comic that does exist
	  Given the comic 'XKCD' is in the database
		And I login as Matt
    When I go to /comics?name=xkcd
    Then I should see "Search Results"
    And I should see "XKCD" 
