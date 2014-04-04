Dir[Rails.root.join('spec/support/featuers/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Features, type: :feature
end
