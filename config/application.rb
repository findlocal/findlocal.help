require_relative "boot"

require "rails"
require "active_record/railtie"
require "active_model/railtie"
require "active_storage/engine"
require "active_job/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_text/engine"
require "action_cable/engine"
require "sprockets/railtie"
require "action_mailer/railtie"
# Mails and tests are currently disabled
# require "action_mailbox/engine"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module LocalHelp
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      # generate.test_framework :test_unit, fixture: false
    end
    config.load_defaults 6.0
    config.generators.system_tests = nil
  end
end
