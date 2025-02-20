require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable Action Controller caching. By default Action Controller caching is disabled.
  # Run rails dev:cache to toggle Action Controller caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.public_file_server.headers = { "cache-control" => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
  end

  # Change to :null_store to avoid any caching.
  config.cache_store = :memory_store

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :minio

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Make template changes take effect immediately.
  config.action_mailer.perform_caching = false
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_SETTINGS_EMAIL_ADDRESS'],
    port: 465,
    domain: ENV['SMTP_SETTINGS_DOMAIN'],
    user_name: ENV['SMTP_SETTINGS_USER_NAME'],
    password: ENV['SMTP_SETTINGS_PASSWORD'],
    authentication: :plain,
    ssl: true,
    tsl: true,
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }

  # https://github.com/rails/propshaft/tree/main?tab=readme-ov-file#improving-performance-in-development
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.default_url_options = { host: 'localhost', port: 5000 }

  # Set localhost to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: "localhost", port: 5000 }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # configure logger
  Rails.logger = Logger.new(STDOUT)
  Rails.logger.datetime_format = '%Y-%m-%d %H:%M:%S'

  config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # DEPRECATION WARNING: `to_time` will always preserve the full timezone rather than offset of the receiver in
  # Rails 8.1. To opt in to the new behavior, set `config.active_support.to_time_preserves_timezone = :zone`.
  config.active_support.to_time_preserves_timezone = :zone

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Append comments with runtime information tags to SQL queries in logs.
  config.active_record.query_log_tags_enabled = true

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  # Apply autocorrection by RuboCop to files generated by `bin/rails generate`.
  # config.generators.apply_rubocop_autocorrect_after_generate!
end

