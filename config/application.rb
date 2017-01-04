require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Psp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local

    config.active_record.raise_in_transactional_callbacks = true

    redis_config = YAML.load_file(Rails.root.join('config', 'redis.yml'))[Rails.env]
    config.cache_store = :redis_store, "redis://#{redis_config['host']}:#{redis_config['port']}/0/#{Rails.env}_cache"

    config.eager_load_paths << Rails.root.join('lib')
  end
end
