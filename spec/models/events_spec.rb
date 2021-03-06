require 'spec_helper'

describe 'An Event' do
  it 'is free if the price is $0' do
    event = Event.new(price: 0)

    expect(event.free?).to eq(true)
  end

  it 'is not free if the price is greater then $0' do
    event = Event.new(price: 10)

    expect(event.free?).to eq(false)
  end

  it 'is free if the price is blank' do
    event = Event.new(price: nil)

    expect(event.free?).to eq(true)
  end

  it 'checks if there is a image' do
    event = Event.create(event_attributes(image_file_name: nil))

    expect(event.image_blank?).to eq(true)
  end

  it 'is only returning upcoming events' do
    event = Event.create(event_attributes)
    expect(Event.count).to eq(1)
    Event.upcoming.first.starts_at >= Time.now
  end

  it 'is only returning events in the future' do
    event = Event.create(event_attributes)

    expect(Event.upcoming).to include(event)
  end

  it 'has a default value for spot' do
    event = Event.create(event_attributes)

    expect(Event.first.capacity).to eq(1)
  end

  it 'does not show events in the past' do
    event = Event.create(event_attributes(starts_at: 1.month.ago))

    expect(Event.upcoming).not_to include(event)
  end

  it 'is ordered by the nearest starts at date' do
    event1 = Event.create(event_attributes(starts_at: 1.month.from_now))
    event2 = Event.create(event_attributes(starts_at: 2.month.from_now))
    event3 = Event.create(event_attributes(starts_at: 3.month.from_now))

    expect(Event.upcoming).to eq([event1, event2, event3])
  end

  it 'name cannot be blank' do
    event = Event.create(event_attributes(name: nil))

    expect(event.valid?).to be_false
    expect(event.errors[:name].any?).to be_true
  end

  it 'description cannot be shorter than 25 characters' do
    event = Event.create(event_attributes(description: 'jadfjsdfjakjgdgs'))

    expect(event.valid?).to be_false
    expect(event.errors[:description].any?).to be_true
  end

  it 'price cannot be a negative number' do
    event = Event.create(event_attributes(price: -10))

    expect(event.valid?).to be_false
    expect(event.errors[:price].any?).to be_true
  end

  it 'price cannot be blank' do
    event = Event.create(event_attributes(price: nil ))

    expect(event.valid?).to be_false
    expect(event.errors[:price].any?).to be_true
  end

  it 'capacity has to be a whole number' do
    event = Event.create(event_attributes(capacity: 10.5 ))

    expect(event.valid?).to be_false
    expect(event.errors[:capacity].any?).to be_true
  end

  it 'images can only have certain extensions' do
    event = Event.create(event_attributes(image_file_name: 'nidosag.pdf'))
    expect(event.valid?).to be_false
    expect(event.errors[:image_file_name].any?).to be_true
  end

  it 'has many registrations' do
    event = Event.create(event_attributes())

    registration1 = event.registrations.new(registration_attributes())
    registration2 = event.registrations.new(registration_attributes())

    expect(event.registrations).to include(registration1)
    expect(event.registrations).to include(registration2)
  end

  it 'deletes associated registration' do
    event = Event.create(event_attributes())

    event.registrations.create(registration_attributes())
    expect{event.destroy}.to change(Registration, :count).by(-1)
  end

  it 'calculates the spots left for each event' do
    event = Event.create(event_attributes(capacity: 5))

    expect(event.spots_left).to eq(5)

    registration = event.registrations.create(registration_attributes())

    expect(event.spots_left).to eq(4)
  end

  it 'checks to see if a event is sold out' do
    event = Event.create(event_attributes(capacity: 1))
    registration = event.registrations.create(registration_attributes())

    expect(event.sold_out?).to be_true
  end

  context '#likes' do
    it 'has many likes' do
      event = Event.create!(event_attributes)
      like1 = Like.create!(like_attributes(event_id: event.id))
      like2 = Like.create!(like_attributes(event_id: event.id))

      expect(event.likes).to include like1
      expect(event.likes).to include like2
    end
  end

  context '#users' do
    it 'returns those that liked' do
      event = Event.create!(event_attributes)
      user1 = User.create!(user_attributes)
      user2 = User.create!(user_attributes(email: 'boss@example.com'))
      Like.create!(like_attributes(event_id: event.id, user_id: user1.id))
      Like.create!(like_attributes(event_id: event.id, user_id: user2.id))

      expect(event.users).to include user1
      expect(event.users).to include user2
    end
  end
end
