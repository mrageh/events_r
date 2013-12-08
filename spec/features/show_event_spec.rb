require "spec_helper"
describe "Viewing an individual event" do
  it "shows the event's details" do
        event = Event.create(event_attributes(price: 10.00))

        visit events_url(event)

        expect(page).to have_content(event.name)
        expect(page).to have_content(event.location)
        expect(page).to have_content("$10.00")
        expect(page).to have_content(event.description)
        expect(page).to have_content(event.starts_at)
  end
end
