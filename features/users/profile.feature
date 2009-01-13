Feature: users/profile
  To view, edit and delete their profile
  A user
  Must have signed up

  Scenario: view profile
    Given Matt has already signed up
    When I go to /users/matt
    Then I should see "Matt's Profile"

	Scenario: Edit Profile Page
		Given I login as Matt
		When I go to /users/matt/edit
		Then I should see "Edit Profile"
		When I fill in "Description" with "Hi I'm a test user"
		And I press "Update"
		Then I should see "Matt's Profile"
		And I should see "Hi I'm a test user"
		
	Scenario: Delete Profile Page
		Given I login as Matt
		When I go to /users/matt/edit
		Then I should see "Edit Profile"
		And I press "Delete Profile"
		Then I should see "Sorry to see you go...  :("
