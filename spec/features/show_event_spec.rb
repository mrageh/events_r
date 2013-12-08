require "spec_helper"
describe "Viewing an individual event" do
  it "shows the event's details" do
        event = Event.create(event_attributes(price: 10.00))

        visit events_url(event)

        expect(page).to have_content(event.name)
        expect(page).to have_content(event.location)
        expect(page).to have_content(event.description)
        expect(page).to have_content(event.starts_at)
  end

  it "shows the price if the price is not $0" do
    event = Event.create(event_attributes(price: 20.00))

    visit event_path(event)

    expect(page).to have_text("$20.00")
  end

  it "shows 'Free' if the price is $0" do
    event = Event.create(event_attributes(price: 0.00))

    visit event_path(event)

    expect(page).to have_text("Free")
  end
end
