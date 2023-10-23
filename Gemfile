source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.5'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv'
gem 'bunny'
gem 'sneakers'
gem 'redis', '~> 4.0'
gem 'redis-rails'
gem 'redis-store'
gem 'rack-cors'
gem 'bson'
gem 'mongo'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
  gem 'rspec-json_expectations'
  gem 'webmock'
end

group :development do
  gem 'capistrano', '~> 3.17', require: false
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
  gem 'capistrano-puma'
  gem 'capistrano-nginx'
  gem 'capistrano-linked-files'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
