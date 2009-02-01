Given /^there is no comic "(.*)"$/ do |c|
  comic = Comic.first(:title => c)
  comic.destroy unless comic.nil?
end

Given /^a comic named "(.*)"$/ do |c|
  Comic.create({:title => c, :description => "This the comic #{c}" })
end

When /^I view the "(.*)" comic page$/ do |c|
  When %{I go to /comics/#{c}}
end

When /^I search comics for "(.*)"$/ do |c|
  When %{I go to /comics?name=#{c}}
end

Then /^I should see HTML instead of markdown/ do
  response.should have_xpath("//em") 
end

Then /^I should see some stars/ do
  response.should match_selector(".star_on")
end

Given /^the comic "(.*)" is tagged with "(.*)"$/ do |comic, tag|
  c = Comic.first(:title => comic)
  c.add_tag(tag)
  c.save
end

When /^I search comics by the tag "(.*)"/ do |t|
  When %{I go to /comics?tag=#{t}}
end
