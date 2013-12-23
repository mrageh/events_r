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
end
