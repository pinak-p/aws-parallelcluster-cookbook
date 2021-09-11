# frozen_string_literal: true

source 'https://rubygems.org'

gem 'berkshelf'

group :style do
  gem 'foodcritic', '~> 16.3.0'
  gem 'rake', '~> 13.0.1'
  gem 'rubocop', '~> 1.18.3'
  gem 'rubocop-gitlab-security', '~> 0.1.1'
end

group :test do
  gem 'chefspec', '~> 9.3.0'
  gem 'kitchen-vagrant', '~> 1.10.0'
  gem 'safe_yaml', '~> 1.0.5'
  gem 'test-kitchen', '~> 2.12.0'
end

group :aws do
  gem 'kitchen-ec2'
end
