require "spec_helper"

describe "Editing the list of events" do
  it "edits the event" do
    User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    ))
    event = Event.create(event_attributes())
    sign_in('adam@example.com', 'password')

    visit edit_event_path(event)

    expect(page).to have_text("Editing #{event.name}")

    fill_in "Name", with: "Clan Battle"
    fill_in "Description", with: "Game night with the clan is fircking awe"
    fill_in "Location", with: "Birmingham"
    fill_in "Price", with: 0
    select "2013", from: "event[starts_at(1i)]"
    select "June", from: "event[starts_at(2i)]"
    select "24",   from: "event[starts_at(3i)]"
    click_button "Update Event"

    expect(page).to have_text("Clan Battle")
    expect(page).to have_text("Event successfully updated!")
    expect(page).to have_text("Game night with the clan")
    expect(page).to have_text("Birmingham")
    expect(page).to have_text("Free")
    expect(page).to have_content("All Events")
    expect(page).to have_content("Edit")
  end
end
