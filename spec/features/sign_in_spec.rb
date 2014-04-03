require 'spec_helper'

feature 'Signing in' do
  before do
    @user = User.create!(user_attributes(
      email: 'Adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    ))
  end

  scenario 'works with a valid email address and password combo' do
    visit root_path

    click_link 'Sign In'

    sign_in(@user.email, 'password')

    expect(current_path).to eq(user_path(@user))
    expect(page).to have_text("Welcome back, #{@user.name}!")
    expect(page).to have_link(@user.name)
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  scenario 'does not work with invalid email address and password combo' do
    visit root_path

    click_link 'Sign In'

    sign_in('bad@example.com', 'invalidpassword')

    expect(page).to have_text('Invalid')
    expect(page).not_to have_link(@user.name)
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
  end
end
