require "spec_helper"

describe "Editing the list of events" do
  it "edits the event" do

    event = Event.create(event_attributes())

    visit edit_event_path(event)

    expect(page).to have_text("Editing #{event.name}")

    fill_in "Name", with: "Clan Battle"
    fill_in "Description", with: "Game night with the clan"
    fill_in "Location", with: "Birmingham"
    fill_in "Price", with: 0

    click_button "Update Event"

    expect(page).to have_text("Clan Battle")
    expect(page).to have_text("Game night with the clan")
    expect(page).to have_text("Birmingham")
    expect(page).to have_text("Free")
    expect(page).to have_text(event.starts_at)
    expect(page).to have_content("All Events")
    expect(page).to have_content("Edit")
  end
end
