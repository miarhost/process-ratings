source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'rails', '~> 7.0.0'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'dotenv'
gem 'bunny'
gem 'sneakers'
gem 'faraday'
gem 'redis', '~> 4.0'
gem 'redis-rails'
gem 'redis-store'
gem 'rack-cors'
gem 'bson'
gem 'mongo'
gem 'mongoid'
gem 'whenever', require: false

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
  gem 'capistrano-puma'
  gem 'capistrano-linked-files'
  gem 'listen', '~> 3.2'
  gem 'spring', '~> 4.1'
  gem 'spring-watcher-listen'
end
