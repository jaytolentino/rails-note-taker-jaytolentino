# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 5.1.0'
gem 'devise'
gem 'factory_bot'
gem 'jbuilder', '~> 2.7'
gem 'net-imap', require: false # Ruby 3.1 bundled gem issue https://stackoverflow.com/a/70500221
gem 'net-pop', require: false # Ruby 3.1 bundled gem issue https://stackoverflow.com/a/70500221
gem 'net-sftp'
gem 'net-smtp', require: false
gem 'psych', '< 4'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.1.4'
gem 'sass-rails', '>= 6'
gem 'sqlite3'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails'
end

group :development do
  gem 'listen'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
