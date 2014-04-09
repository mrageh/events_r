require 'spec_helper'

describe Registration do

  it "belongs to a event" do
    event = Event.create(event_attributes())

    registration  =  event.registrations.new(registration_attributes())
    expect(registration.event).to eq(event)
  end

  it "with example attributes is valid" do
    registration = Registration.create(registration_attributes())

    expect(registration.valid?).to be_true
  end

  it "accepts a valid choice on how event was heard about" do
    how_heard_options = ['Newsletter', 'Twitter', 'Blog Post', 'Web Search', 'Friend/Coworker', 'Other']

    how_heard_options.each do |heard|
      registered = Registration.create(registration_attributes(how_heard: heard))

      expect(registered.valid?).to be_true
      expect(registered.errors[:how_hear].any?).to be_false
    end
  end

  it "rejects a invalid choice on how event was heard" do
    how_heard_options = ['Netter', 'ter', ' Post', 'Search', 'Coworker', 'her']

    how_heard_options.each do |heard|
      registered = Registration.create(registration_attributes(how_heard: heard))

      expect(registered.valid?).to be_false
      expect(registered.errors[:how_heard].any?).to be_true
    end
  end
end
