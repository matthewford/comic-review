Given 'Matt has already signed up' do
  @user = User.new(:username => 'Matt', :email => 'matt@test.com', :password => 'justt3sting')
	@user.password_confirmation = 'justt3sting'
	@user.save
end

Given 'I login as Matt' do
  When %{Matt has already signed up}
	When %{I go to /login}
	Then %{I fill in "Email" with "matt@test.com"} 
	And %{I fill in "Password" with "justt3sting"}
	And %{I press "Log In"}
	Then %{the request should be successful}
	And %{I should see "Authenticated Successfully"}
end

# Then %r{^test session} do
# 	puts session.user
# end
# Add your steps here
#
# A few examples:
#
# Given %r{^I was registered with ([^/\s]+)/(\S+)}i do |email, password|
#   @current_person = Person.generate(:email => email, :password => password))
# end
#
# Given %r{^I am authenticated as ([^/\s]+)/(\S+)}i do |email, password|
#   Given %{I was registered with #{email}/#{password}}
#   Then %{I can log in as #{email}/#{password}}  
# end
#
# Then %r{^I can log in as ([^/\s]+)/(\S+)}i do |email, password|
#   When %{I try to log in as #{email}/#{password}}
#   Then %{I should be redirected to /dashboard}
# end
#
# Then %r{^I can not log in as ([^/\s]+)/(\S+)}i do |email, password|
#   When %{I try to log in as #{email}/#{password}}
#   Then %{I should be redirected to /sessions}
#   And %{I should see "Wrong e-mail or password!"}
# end