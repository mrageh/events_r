require "spec_helper"

describe "Viewing the list of events" do
  it "shows the event" do

    event1 = Event.create(name: "BugSmash",
                          location: "Denver",
                          price: 10.00,
                          description: 'A fun evening of bug smashing!',
                          starts_at: 10.days.from_now)

    event2 = Event.create(name: "Hackathon",
                          location: "Austin",
                          price: 15.00,
                          description: 'Hunker down at the Hackathon!',
                          starts_at: 15.days.from_now)

    event3 = Event.create(name: "Kata Camp",
                          location: "Dallas",
                          price: 75.00,
                          description: 'Practice your craft kata style!',
                          starts_at: 30.days.from_now)

    event4 = Event.create(name: "In the past",
                          location: "Austin",
                          price: 15.00,
                          description: 'Hunker down at the Hackathon!',
                          starts_at: 5.days.ago)

    visit events_path

    expect(page).to have_text("3 Events")
    expect(page).to have_text(event1.name)
    expect(page).to have_text(event2.name)
    expect(page).to have_text(event3.name)

    expect(page).to have_text(event1.location)
    expect(page).to have_text(event1.description[0..10])
    expect(page).to have_text("$10.00")
  end

  it "does not list a event in the past" do
    event = Event.create(event_attributes(starts_at: 1.month.ago))

    visit events_path

    expect(page).not_to have_text(event.name)
  end
end
