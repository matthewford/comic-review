Given /^the comic 'XKCD' is not the database$/ do
  comic = Comic.first(:title => 'XKCD')
  comic.destroy unless comic.nil?
end

Given /^the comic 'XKCD' is in the database$/ do
  Comic.create({:title => 'XKCD', :description => "This the XKCD comic" })
end

Then /^I should see HTML instead of markdown/ do
  response.should have_xpath("//em") 
end