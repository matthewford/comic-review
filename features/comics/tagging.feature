Feature: comics/tagging
  To search comics by tags
  A User can tag a comic

  Scenario: creating a tag
    Given a comic named "XKCD" 
    And I login as Matt
    When I view the "xkcd" comic page
    And I fill in "comic[new_tag]" with "humor"
    And I press "Add Tag"
    Then I should see "humor"
    
  Scenario: Searching by a tag
    Given a comic named "XKCD"
    Given a comic named "Zero Punctuation" 
    Given a comic named "Penny Arcade" 
    Given the comic "XKCD" is tagged with "humor"     
    Given the comic "Zero Punctuation" is tagged with "humor"     
    When I search comics by the tag "humor"
    Then I should see "XKCD"
    And I should see "Zero Punctuation" 
    And I should not see "Penny Arcade"  
    