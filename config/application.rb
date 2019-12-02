require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)
Dotenv::Railtie.load

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Invoicer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    # disable some tests we don't need
    config.generators do |g|
      g.test_framework :rspec,
      fixtures: false,
      view_specs: true,
      helper_specs: false,
      routing_specs: false
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
