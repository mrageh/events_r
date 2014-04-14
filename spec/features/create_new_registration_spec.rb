require 'spec_helper'

feature "Creating a new Registration" do
  before do
    @user = User.create!(user_attributes)
  end

  scenario "saves the registrations to its associated event and user" do
    event = Event.create(event_attributes)
    sign_in('user@example.com', 'secret')

    visit event_path(event)
    expect(current_path).to eq(event_path(event))

    click_on "Register!"

    expect(current_path).to eq(new_event_registration_path(event))
    expect(page).to have_text("Registration for #{event.name}")

    select "Twitter", from: "How heard"
    click_button "Create Registration"

    expect(current_path).to eq(event_registrations_path(event))
    expect(page).to have_text("Thanks for registering #{@user.name}!")
    expect(page).to have_link("#{@user.name}")
  end

  scenario "does not save invalid registration" do
    event = Event.create(event_attributes)
    sign_in('user@example.com', 'secret')

    visit event_path(event)
    expect(current_path).to eq(event_path(event))

    click_on "Register!"

    expect(current_path).to eq(new_event_registration_path(event))
    expect(page).to have_text("Registration for #{event.name}")

    click_button "Create Registration"

    expect(page).to have_text("The registration could not be saved")
    expect(page).to have_text("How heard is not included in the list")
  end

  scenario 'does not save when no user is signed in' do
    event = Event.create(event_attributes)
    visit event_path(event)

    expect(current_path).to eq(event_path(event))

    click_on "Register!"

    expect(current_path).to eq(signin_path)
  end
end
