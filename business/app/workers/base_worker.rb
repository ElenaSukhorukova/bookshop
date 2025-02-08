class BaseWorker
  include Sidekiq::Job

  private

  def initiate_logger(log_type, msg)
    Rails.logger.send(log_type, msg)
  end
end
