require 'spec_helper'

describe Like do
  context '#event' do
    it 'belongs to a event' do
      event = Event.create!(event_attributes)
      like = Like.create!(like_attributes(event_id: event.id))

      expect(like.event).to eq event
    end
  end

  context '#user' do
    it 'belongs to a user' do
      user = User.create!(user_attributes)
      like = Like.create!(like_attributes(user_id: user.id))

      expect(like.user).to eq user
    end
  end
end
