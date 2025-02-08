# frozen_string_literal: true

module Sessions
  class Omniauth < Base::MicroCase
    attributes :params

    def call!
      return fail_result(msg: I18n.t('errors.blank_params'), type: :blank_params) if params.blank?

      ActiveRecord::Base.transaction do
        user = User.from_omniauth(params)

        return fail_result(msg: user.errors.full_messages.join('; ')) if user.new_record?

        Success result: { user: user }
      end
    end
  end
end
