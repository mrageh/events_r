require 'spec_helper'

feature 'Viewing a users profile page' do
  before do
    @user = User.create!(user_attributes(name: "Larry", email: "larry@example.com"))
    @event1 = Event.create(
      name: "BugSmash",
      location: "Denver",
      price: 10.00,
      description: 'A fun evening of bug smashing!',
      starts_at: 10.days.from_now,
    )
    @event2 = Event.create(
      name: "Hackathon",
      location: "Austin",
      price: 15.00,
      description: 'Hunker down at the Hackathon!',
      starts_at: 15.days.from_now,
    )
    @registration1 = Registration.create!(registration_attributes(
      user_id: @user.id,
      event_id: @event1.id,
    ))
    @registration2 = Registration.create!(registration_attributes(
      user_id: @user.id,
      event_id: @event2.id,
    ))
  end

  scenario 'shows the users details and all that users registrations' do
    sign_in(@user.email, 'secret')
    visit user_path(@user)

    expect(page).to have_text(@user.name)
    expect(page).to have_text(@user.email)
    expect(page).to have_text('Currently Registered For:')
    expect(page).to have_text(@registration1.event.name)
    expect(page).to have_text(@registration2.event.name)
  end
end
