require "spec_helper"

describe "Deleting a event" do
  it "allows us to delete an event" do
    event = Event.create(event_attributes(price: 10.00))

    visit event_url(event)

    expect(Event.count).to eq(1)

    click_on "Delete"

    expect(Event.count).to eq(0)
    expect(page).to have_text("Event successfully deleted")
    expect(current_path).to eq(events_path)
  end
end
