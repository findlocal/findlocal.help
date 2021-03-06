source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

# Core
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
gem "pg", ">= 0.18", "< 2.0" # postgresql as database
gem "puma", "~> 4.3" # app server
gem "sass-rails", ">= 6" # scss instead of css
gem "webpacker", "~> 3.5.5" # webpack for js
gem "turbolinks", "~> 5" # make navigation faster
gem "jbuilder", "~> 2.7" # build an api and render json
gem "redis", "~> 4.0" # run action cable
gem "bootsnap", ">= 1.4.2", require: false # improve caching

# Extensions
gem "cloudinary", "~> 1.12.0"
gem "devise"
gem "faker"
gem "geocoder"
gem "pundit"
gem "money-rails"
gem "stripe"
gem "stripe_event"
gem "algolia_places"
gem 'mapbox-gl-rails'

# Frontend
gem "autoprefixer-rails" # adds -webkit- and similar prefixes to css rules
gem "font-awesome-sass"
gem "simple_form"

# Tasks
gem "paint" # colors for terminal
gem "whirly" # terminal spinner

group :development, :test do
  gem "dotenv-rails" # use a private .env file to store your keys
  gem "pry-byebug" # call `binding.pry` anywhere in the code to stop the execution and get a debugger console
  gem "pry-rails"
  gem "rubocop"
  gem "rubocop-rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rails_real_favicon"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem:
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
