require 'spec_helper'

describe "Creating a new event" do
  before do
    @user = User.create!(user_attributes(
      email: 'adam@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    ))
  end

  it "allows me to make a new event" do
    visit root_path
    sign_in('adam@example.com', 'password')
    click_on "Add New Event"

    expect(current_path).to eq(new_event_path)
    expect(page).to have_content("Add New Event")

      fill_in "Name", with: "Clan Battle"
      fill_in "Description", with: "x" * 26
      fill_in "Location", with: "gSchool"
      fill_in "Price", with: 10
      fill_in "Image Filename", with: "placeholder.png"
      fill_in "Capacity", with: 100
      select "2013", from: "event[starts_at(1i)]"
      select "June", from: "event[starts_at(2i)]"
      select "24",   from: "event[starts_at(3i)]"
      click_on "Create Event"

    expect(page).to have_text("Event successfully created!")
    expect(page).to have_content("Clan Battle")
  end

  it "adds a default image if none is specified" do
    visit root_path
    sign_in('adam@example.com', 'password')
    click_on "Add New Event"

    fill_in "Name", with: "Clan Battle"
    fill_in "Description", with: "D" * 25
    fill_in "Location", with: "gSchool"
    fill_in "Price", with: 10
    fill_in "Capacity", with: 100
    select "2013", from: "event[starts_at(1i)]"
    select "June", from: "event[starts_at(2i)]"
    select "24",   from: "event[starts_at(3i)]"
    click_on "Create Event"

    expect(page).to have_selector("img[src$='#{Event.last.image_file_name}']")
  end
end
