require 'spec_helper'

describe "Creating a new Registration" do
  it "saves the registrations to its associated event" do
    event = Event.create(event_attributes)

    visit event_path(event)
    expect(current_path).to eq(event_path(event))

    click_on "Register!"
    expect(current_path).to eq(new_event_registration_path(event))

    expect(page).to have_text("Registration for #{event.name}")

    fill_in "Full name", with: "Testing"
    fill_in "Email", with: "adam@example.com"
    select "Twitter", from: "How heard"
    click_button "Create Registration"

    expect(current_path).to eq(event_registrations_path(event))
    expect(page).to have_text("Testing")
    expect(page).to have_text("Thanks for registering!")
  end

  it "does not save invalid registration" do
    event = Event.create(event_attributes)

    visit event_path(event)
    expect(current_path).to eq(event_path(event))

    click_on "Register!"
    expect(current_path).to eq(new_event_registration_path(event))

    expect(page).to have_text("Registration for #{event.name}")

    fill_in "Full name", with: "Testing"
    fill_in "Email", with: "adam@example.com"
    click_button "Create Registration"

    expect(page).to have_text("The registration could not be saved")
    expect(page).to have_text("How heard is not included in the list")
  end
end
