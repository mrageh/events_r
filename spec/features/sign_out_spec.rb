require 'spec_helper'

feature 'Signing out' do
  scenario 'logs user out of app' do
    user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))

    visit root_path

    click_link 'Sign In'

    sign_in(user.email, 'password')

    click_link 'Sign Out'

    expect(page).not_to have_link('Sign Out')
    expect(page).not_to have_text(user.name)
    expect(page).to have_text('signed out')
  end
end
