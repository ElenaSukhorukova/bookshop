class DeletionUnactivatedUserWorker < BaseWorker
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)

    if user.blank?
      initiate_logger(
        :info,
        "#{self.class} >> user wasn't found with id: #{user_id}"
      )

      return
    end

    user.destroy
  end
end
