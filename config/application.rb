require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
require "mongoid/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module News
  class Application < Rails::Application

    config.i18n.load_path += Dir[Rails.root.join('locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    config.encoding = "utf-8"

    config.filter_parameters += [:password, :password_confirmation]

    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true

    config.assets.version = '1.0'
  end
end
