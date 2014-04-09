def event_attributes(overrides = {})
  {
    name: "BugSmash",
    location: "Denver",
    price: 10.00,
    description: "A fun evening of bug smashing",
    starts_at: 10.days.from_now,
    image_file_name: "placeholder.png",
  }.merge(overrides)
end

def registration_attributes(overrides = {})
  {
    how_heard: "Twitter",
    event_id: 1,
  }.merge(overrides)
end

def user_attributes(overrides = {})
  {
    name: "Example User",
    email: "user@example.com",
    password: "secret",
    password_confirmation: "secret",
    admin: false,
  }.merge(overrides)
end
