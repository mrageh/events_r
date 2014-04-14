require 'spec_helper'

describe User do
  before do
    @user = User.new(
      name: 'Adam',
      email: 'Adam@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @event1 = Event.create(
      name: "BugSmash",
      location: "Denver",
      price: 10.00,
      description: 'A fun evening of bug smashing!',
      starts_at: 10.days.from_now,
    )

    @event2 = Event.create(
      name: "Hackathon",
      location: "Austin",
      price: 15.00,
      description: 'Hunker down at the Hackathon!',
      starts_at: 15.days.from_now,
    )

  end
  context '#email' do
    it 'is valid' do
      @user.email = 'Adam@example.com'

      expect(@user).to be_valid
    end

    it 'is invalid' do
      @user.email = 'invalid email'

      expect(@user).not_to be_valid
    end

    it 'is invalid when blank' do
      @user.email = ''

      expect(@user).not_to be_valid
    end
  end

  context '#name' do
    it 'is valid' do
      @user.name = 'Adam'

      expect(@user).to be_valid
    end

    it 'is invalid when blank' do
      @user.name = ''

      expect(@user).not_to be_valid
    end
  end

  context '#registrations' do
    it 'hash many registrations' do
      @user.save
      user =  @user
      registration1 = Registration.create!(registration_attributes(
        user_id: user.id,
        event_id: @event1.id,
      ))
      registration2 = Registration.create!(registration_attributes(
        user_id: user.id,
        event_id: @event2.id,
      ))

      expect(user.registrations.count).to eq 2
      expect(user.registrations).to include(registration1)
      expect(user.registrations).to include(registration2)
    end
  end
end
