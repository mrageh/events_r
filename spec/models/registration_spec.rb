require 'spec_helper'

describe Registration do
  it "accepts to register if name is present" do
    registered = Registration.create(registration_attributes())

    expect(registered.valid?).to be_true
    expect(registered.errors[:full_name].any?).to be_false
  end

  it "rejects if name is absent" do
    registered = Registration.create(registration_attributes(full_name: nil))

    expect(registered.valid?).to be_false
    expect(registered.errors[:full_name].any?).to be_true
  end

  it "accepts if email is valid" do
    registered = Registration.create(registration_attributes())

    expect(registered.valid?).to be_true
    expect(registered.errors[:email].any?).to be_false
  end

  it "rejects invalid email address" do
    registered = Registration.create(registration_attributes(email: "invalid"))

    expect(registered.valid?).to be_false
    expect(registered.errors[:email].any?).to be_true
  end

  it "rejects a blank email address" do
    registered = Registration.create(registration_attributes(email: nil))

    expect(registered.valid?).to be_false
    expect(registered.errors[:email].any?).to be_true
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