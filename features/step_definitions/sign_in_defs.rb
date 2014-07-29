Given /^I am signed up as email@email.com with password 12345678$/ do
   step 'I can connect to the internet'
   step 'I visit "/users/sign_up"'
   step 'I enter "email@email.com" as my "user email"'
   step 'I enter "12345678" as my "user password"'
   step 'I enter "12345678" as my "user password confirmation"'
   step 'I enter "12345" as my "user zip"'
   step 'I press "Sign Up"'
end

Given /^I am signed out$/ do
  step 'I press "Sign out"'
end


