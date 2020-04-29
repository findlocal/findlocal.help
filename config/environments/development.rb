Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Reload code on every request
  config.cache_classes = false

  # add your own ngork link when testing
  config.hosts << "e247ee1e.ngrok.io"

  # Do not eager load code on boot
  config.eager_load = false

  # Show full error reports
  config.consider_all_requests_local = true

  # Enable/disable caching (disabled by default, run rails dev:cache to toggle it)
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on Cloudinary (see config/storage.yml for other options)
  config.active_storage.service = :cloudinary

  # Mailers
  # config.action_mailer.raise_delivery_errors = false
  # config.action_mailer.perform_caching = false

  # Show deprecation warnings
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets (faster)
  config.assets.debug = true
  config.assets.check_precompiled_asset = true

  # Suppress logger output for asset requests
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code (routes, locales, etc.)
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
