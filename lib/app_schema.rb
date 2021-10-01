require "i18n"
require "dry-validation"

class AppSchema < Dry::Validation::Schema
  config.messages.default_locale = ENV["DEFAULT_LOCALE"]
  config.messages.load_paths << 'config/errors.yml'
end
