module Users
  class InitiateActivation < Base::MicroCase
    attributes :user

    def call!
      return fail_result(msg: I18n.t('errors.uncatched_error')) if user.blank?

      if user.activated?
        return Success result: { user: user,
                                 msg: I18n.t('operations.authentication_process.successful_enter'),
                                 activated: true }
      end

      user.initiate_activate_process

      Success result: { msg: I18n.t('operations.created_user.check_email'), user: user }
    end
  end
end
