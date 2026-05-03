require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module BlogApp
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.generators.system_tests = nil
    config.relative_url_root = "/blog"
    config.time_zone = "America/Sao_Paulo"
    config.i18n.default_locale = :"pt-BR"
    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml")]
  end
end
