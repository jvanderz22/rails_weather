Then /^I should not be signed in$/ do
  expect(page).to_not have_content("Signed in as")
end
