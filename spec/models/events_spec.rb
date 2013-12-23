require "spec_helper"

describe "An Event" do
  it "is free if the price is $0" do
    event = Event.new(price: 0)

    expect(event.free?).to eq(true)
  end

  it "is not free if the price is greater then $0" do
    event = Event.new(price: 10)

    expect(event.free?).to eq(false)
  end

  it "is free if the price is blank" do
    event = Event.new(price: nil)

    expect(event.free?).to eq(true)
  end

  it "is only returning upcoming events" do
    event = Event.create(event_attributes)
    expect(Event.count).to eq(1)
    Event.upcoming.first.starts_at >= Time.now
  end

  it "is only returning events in the future" do
    event = Event.create(event_attributes)

    expect(Event.upcoming).to include(event)
  end

  it "does not show events in the past" do
    event = Event.create(event_attributes(starts_at: 1.month.ago))

    expect(Event.upcoming).not_to include(event)
  end

  it "is ordered by the nearest starts at date" do
    event1 = Event.create(event_attributes(starts_at: 1.month.from_now))
    event2 = Event.create(event_attributes(starts_at: 2.month.from_now))
    event3 = Event.create(event_attributes(starts_at: 3.month.from_now))

    expect(Event.upcoming).to eq([event1, event2, event3])
  end
end
