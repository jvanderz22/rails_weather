Given /^I am signed in with password "(.*)" and registered for emails and texts$/ do |password|
  step 'I can connect to the internet'
  step 'I visit "/users/sign_up"'
  step 'I enter "email@email.com" as my "user email"'
  step "I enter \"#{password}\" as my \"user password\""
  step "I enter \"#{password}\" as my \"user password confirmation\""
  check("user_send_email")
  check("user_send_text")
  step 'I enter "12345" as my "user zip"'
  step 'I press "Sign Up"'
end

When /^I uncheck "(.*)"$/ do |check_box|
  uncheck(check_box.gsub(" ","_"))
end

Then /^the checkbox "(.*)" is unchecked$/ do |check_box|
  expect(has_unchecked_field?(check_box.gsub(" ", "_"))).to be true
end

Then /^the checkbox "(.*)" is checked$/ do |check_box|
  expect(has_checked_field?(check_box.gsub(" ", "_"))).to be true
end
