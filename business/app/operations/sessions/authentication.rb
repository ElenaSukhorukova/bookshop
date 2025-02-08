module Sessions
  class Authentication < Base::MicroCase
    attributes :session, :password, :remember_me

    def call!
      return fail_result(msg: I18n.t('errors.uncatched_error')) if session.blank?

      unless session.user.authenticate(password)
        return fail_result(type: :unauthorized,
                           msg: I18n.t('errors.invalid_password_or_email'))
      end

      return fail_result(type: :invalid_params, msg: session.full_messages.join('; ')) unless session.save

      Success result: {
        session: session,
        remember_me: remember_me,
        msg: I18n.t('operations.authentication_process.successful_enter')
      }
    end
  end
end
