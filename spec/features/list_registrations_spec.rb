require 'spec_helper'

feature "Listing Registrations" do
  before do
    @user = User.create!(user_attributes)
    sign_in('user@example.com', 'secret')
  end

  scenario "shows the registrations for a specific event" do
    event1 = Event.create!(event_attributes(name: "Classical Reading"))
    registration1 = event1.registrations.create!(registration_attributes(user_id: @user.id))
    registration2 = event1.registrations.create!(registration_attributes(user_id: @user.id))


    event2 = Event.create!(event_attributes(name: "Super"))
    registration3 = event2.registrations.create!(registration_attributes(how_heard: 'Other'))

    visit event_registrations_url(event1)

    expect(page).to have_text(registration1.how_heard)
    expect(page).to have_text(registration2.how_heard)
    expect(page).not_to have_text(registration3.how_heard)
  end
end
