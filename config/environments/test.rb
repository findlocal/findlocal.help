Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  config.cache_classes = false

  # Do not eager load code on boot
  config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{1.hour.to_i}"
  }

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Store uploaded files on the local file system in a temporary directory
  config.active_storage.service = :test

  # Mailers
  # config.action_mailer.perform_caching = false
  # config.action_mailer.delivery_method = :test

  # Don't print deprecation notices
  config.active_support.deprecation = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
