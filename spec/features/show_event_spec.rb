require "spec_helper"
describe "Viewing an individual event" do
  it "shows the event's details" do
        event = Event.create(event_attributes(price: 10.00))

        visit event_url(event)

        expect(page).to have_content(event.name)
        expect(page).to have_content(event.location)
        expect(page).to have_content(event.description)
        expect(page).to have_content(event.starts_at)
        expect(page).to have_content("All Events")
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

  it "shows 'Sold out' if a event has no more spots left" do
    event = Event.create(event_attributes(capacity: 1))
    registration = event.registrations.create(registration_attributes)

    visit event_path(event)

    expect(current_path).to eq(event_path(event))
    expect(page).to have_text("Sold out")
    expect(page).not_to have_link("Register!")
  end
end
