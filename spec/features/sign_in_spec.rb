require 'spec_helper'

feature 'Signing in' do
  before do
    @user = User.create!(user_attributes(
      name: 'Adam',
      email: 'Adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    )) 
  end

  scenario 'works with a valid email address and password combo' do
    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: @user.email 
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq(user_path(@user))

    expect(page).to have_text("Welcome back, #{@user.name}!")
  end

  scenario 'does not work with invalid email address and password combo' do
    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: 'bad@example.com'
    fill_in 'Password', with: 'invalidpassword'
    click_button 'Sign In'

    expect(page).to have_text('Invalid')
  end
end
