require 'spec_helper'

feature 'Deleting a user' do
  scenario 'destroys the user and redirects to the home page'  do
    user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))
    sign_in(user.email, 'password')

    visit user_path(user)

    click_link 'Delete Account'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')

    visit users_path

    expect(page).not_to have_text(user.name)
  end

  scenario 'automatically signs out that user' do
    user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))

    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    visit user_path(user)
    click_link 'Delete Account'

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Account successfully deleted!')
  end
end
