require 'spec_helper'

feature 'Viewing a users profile page' do
  scenario 'shows the users details' do
    user = User.create!(user_attributes(name: "Larry", email: "larry@example.com"))
    sign_in(user.email, 'secret')
    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end
