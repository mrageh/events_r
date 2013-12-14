require "spec_helper"

describe "Navigate events" do
  it "allows navigation from the details page to the listing page" do
    event = Event.create(event_attributes)
    visit event_path(event)

    click_link "All Events"

    expect(current_path).to eq(events_path)
  end

  it "allows navigation from the listing page to the detail page" do
    event = Event.create(event_attributes)
    visit events_path

    click_link event.name

    expect(current_path).to eq(event_path(event))
  end
end
