source "https://rubygems.org"

ruby "2.4.5"

# the most important stuff
gem "rails", "4.2.8"
gem "pg"
gem "rails-api"
gem "rails_api_format", git: "https://github.com/fs/rails-api-format.git"

# all other gems
gem "active_model_serializers", git: "https://github.com/rails-api/active_model_serializers.git"
gem "decent_exposure"
gem "devise"
gem "health_check"
gem "interactor"
gem "kaminari"
gem "rack-cors", require: "rack/cors"
gem "responders"
gem "rollbar"
gem "seedbank"
gem "simple_token_authentication"
gem "thin"
gem "sidekiq"
gem "sidekiq-scheduler"

group :development do
  gem "letter_opener"
  gem "foreman"
  gem "bullet"

  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "byebug"
  gem "dotenv-rails"
  gem "rspec-rails", "~> 3.5", ">= 3.5.2"
  gem "mail_safe"

  gem "brakeman"
  gem "rubocop"
  gem "bundler-audit"
end

group :test do
  gem "simplecov", require: false
  gem "webmock", require: false

  gem "database_cleaner"
  gem "email_spec"
  gem "shoulda-matchers", require: false
  gem "json_spec"
end

group :development, :test, :staging do
  gem "faker"
  gem "factory_girl_rails"
  gem "rspec_api_documentation"
  gem "apitome", '0.2.0'
end
