module Base
  class MicroCase < Micro::Case
    private

    def fail_result(msg:, type: nil,user: nil)
      Rails.logger.debug("#{self.class} >> #{msg}")

      return Failure type, result: { user: user, msg: msg } if type.present?

      Failure result: { user: user, msg: msg }
    end
  end
end
