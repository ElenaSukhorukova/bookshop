module Base
  class MicroCase < Micro::Case
    private

    def fail_result(msg:, type: nil)
      Rails.logger.debug("#{self.class} >> #{msg}")

      return Failure type, result: { msg: msg } if type.present?

      Failure result: { msg: msg }
    end
  end
end
