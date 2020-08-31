source 'https://rubygems.org'
ruby '2.6.5'

gem 'bootsnap', require: false
gem 'devise'
gem 'jbuilder', '~> 2.0'
gem 'pg', '~> 0.21'
gem 'puma'
gem 'rails', '6.0.2.1'
gem 'redis'

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.12.0'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'
gem 'webpacker'
# gem 'rails-sweetalert2-confirm'
# gem 'rails-assets-sweetalert2', '~> 5.1.1', source: 'https://rails-assets.org'
# gem 'sweet-alert2-rails'

# Geocoding gem for GoogleMaps
gem 'geocoder'
gem 'aws-sdk-s3', require: false
gem 'carrierwave', '~> 2.0'
gem 'fog-aws'

# Update August 2020



# Algolia Search
gem "algoliasearch-rails"


group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'letter_opener'
end

group :development, :test do
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'dotenv-rails'
  gem 'table_print'
end

group :test do
  gem 'factory_bot_rails'
end
