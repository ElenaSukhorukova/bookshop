module PasswordReset
  class ValidateExpirationOfToken < Base::MicroCase
    attributes :params

    def call!
      return fail_result(msg: I18n.t('errors.pass_reset_expired')) if user.blank?

      Success result: { user: user }
    end

    private

    def user
      @user ||= User.find_by_token_for(:reset_token, params[:id])
    end
  end
end
