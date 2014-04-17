source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.0.2'
gem 'sass-rails', '~> 4.0.0'
gem 'awesome_print', :require => 'ap'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'newrelic_rpm'
gem 'bcrypt-ruby'
gem 'thin'

group :test, :development do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'sqlite3'
  gem 'meta_request'
end

group :development do
  gem 'spring'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :doc do
  gem 'sdoc', require: false
end
