require 'spec_helper'

feature 'Creating a new user' do
  scenario 'saves the user and shows the users profile page' do
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in "Name",  with: "Example User"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "secret"
    fill_in "Confirm Password", with: "secret"

    click_button 'Create User'

    expect(current_path).to eq(user_path(User.last))

    expect(page).to have_text('Example User')
    expect(page).to have_text('Thanks for signing up!')
  end

  scenario 'does not save the user if its invalid' do
    visit signup_url

    expect {
      click_button 'Create User'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end
