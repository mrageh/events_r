require 'spec_helper'

feature 'Editing a user' do
  scenario 'updates a user and shows updated details' do
    user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))
    sign_in(user.email, 'password')

    visit user_url(user)

    click_link 'Edit Account'

    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('Name').value).to eq(user.name)

    fill_in "Name", with: "Updated User Name"

    click_button "Update Account"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Updated User Name")
    expect(page).to have_text('Account successfully updated!')
  end

  scenario 'does not update the user if invalid' do
    user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))
    sign_in(user.email, 'password')

    visit edit_user_url(user)

    fill_in 'Name', with: " "

    click_button "Update Account"

    expect(page).to have_text('error')
  end
end
