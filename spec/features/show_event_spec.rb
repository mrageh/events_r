require "spec_helper"
describe "Viewing an individual event" do
  it "shows the event's details" do
        event = Event.create(name: "BugSmash",
                          location: "Denver",
                          price: 10.00,
                          description: 'A fun evening of bug smashing!',
                          starts_at: 10.days.from_now)

        visit events_url(event)

        expect(page).to have_content(event.name)
        expect(page).to have_content(event.location)
        expect(page).to have_content("$10.00")
        expect(page).to have_content(event.description)
        expect(page).to have_content(event.starts_at)
  end
end
