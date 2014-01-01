require 'spec_helper'

describe "Listing Registrations" do
  it "should show a list of registered users only for that event" do
    event = Event.create(event_attributes)
    registration1 = event.registrations.create(registration_attributes)
    registration2 = event.registrations.create(registration_attributes(full_name: "two"))
    registration3 = event.registrations.create(registration_attributes(full_name: "three"))

    event1 = Event.create(event_attributes)
    registration = event1.registrations.create(registration_attributes(full_name: "Lool"))

    visit event_registrations_path(event)

    expect(current_path).to eq(event_registrations_path(event))
    expect(event.registrations.count).to eq(3)

    expect(page).to have_text(registration1.full_name)
    expect(page).to have_text(registration2.full_name)
    expect(page).to have_text(registration3.full_name)

    expect(page).not_to have_text(registration.full_name)
  end
end
