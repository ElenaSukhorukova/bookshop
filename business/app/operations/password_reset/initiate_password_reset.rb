module PasswordReset
  class InitiatePasswordReset < Base::MicroCase
    attributes :params

    def call!
      return fail_result(type: :blank_params, msg: I18n.t('errors.blank_params')) if params.blank?
      return fail_result(type: :invalid_params, msg: I18n.t('errors.invalid_email')) if user.blank?

      return fail_result(type: :unactivated_user, msg: I18n.t('errors.unactivated_account')) unless user.activated?

      user.initiate_reset_password_process

      Success result: { msg: I18n.t('operations.initiate_password_reset.check_email') }
    end

    private

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end
  end
end
