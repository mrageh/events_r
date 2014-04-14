require 'spec_helper'

feature 'Viewing an individual event' do
  scenario 'shows the events details' do
    event = Event.create(event_attributes(price: 10.00))

    visit event_url(event)

    expect(page).to have_content(event.name)
    expect(page).to have_content(event.location)
    expect(page).to have_content(event.description)
    expect(page).to have_content(event.starts_at)
    expect(page).to have_content('All Events')
  end


  scenario 'shows the price if the price is not $0' do
    event = Event.create(event_attributes(price: 20.00))

    visit event_path(event)

    expect(page).to have_text('$20.00')
  end

  scenario 'shows Free if the price is $0' do
    event = Event.create(event_attributes(price: 0.00))

    visit event_path(event)

    expect(page).to have_text('Free')
  end

  scenario 'shows Sold out if a event has no more spots left' do
    event = Event.create(event_attributes(capacity: 1))
    event.registrations.create(registration_attributes)

    visit event_path(event)

    expect(current_path).to eq(event_path(event))
    expect(page).to have_text('Sold out')
    expect(page).not_to have_link('Register!')
  end

  scenario 'shows number of likes and the names of users as link' do
    event = Event.create!(event_attributes)
    user1 = User.create!(user_attributes(name: 'Dexter'))
    user2 = User.create!(user_attributes(
      name: 'Ralph',
      email: 'boss@example.com'
    ))
    Like.create!(like_attributes(
      event_id: event.id,
      user_id: user1.id
    ))
    Like.create!(like_attributes(
      event_id: event.id,
      user_id: user2.id
    ))

    visit event_path(event)

    expect(page).to have_text '2 Likes'
    expect(page).to have_link 'Dexter'
    expect(page).to have_link 'Ralph'
  end

  scenario 'allows a user to like a event and unlike an event' do
    event = Event.create!(event_attributes)
    user = User.create!(user_attributes(name: 'Dexter'))

    sign_in(user.email, 'secret')
    visit event_path(event)
    click_button 'Like'

    expect(page).to have_text '1 Like'
    expect(page).not_to have_button 'Like'
    expect(page).to have_button 'Unlike'

    click_button 'Unlike'

    expect(page).to have_text '0 Likes'
    expect(page).to have_button 'Like'
  end
end
