# frozen_string_literal: true

sidekiq_config = { url: ENV['REDIS_URL'] }

Sidekiq.configure_server do |config|
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
