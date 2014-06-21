require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AccountedApi
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.fixture_replacement :factory_girl
      g.helper false
      g.assets false
      g.view_specs false
    end

    config.time_zone = 'Central Time (US & Canada)'
  end
end
