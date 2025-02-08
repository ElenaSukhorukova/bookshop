# frozen_string_literal: true

module Sessions
  class NewSession < Base::MicroCase
    attributes :params

    def call!
      return fail_result(type: :blank_params, msg: I18n.t('errors.blank_params')) if params.blank?

      validation = validate_params

      unless validation.success?
        return fail_result(type: :invalid_params,
                           msg: validation.errors(full: true).to_h.values.flatten.join('; '))
      end

      return fail_result(type: :invalid_params, msg: I18n.t('errors.invalid_password_or_email')) if user.blank?
      return fail_result(type: :unactivated_user, msg: I18n.t('errors.unactivated_account')) unless user.activated?

      Success result: { session: session, password: params[:password], remember_me: params[:remember_me] }
    end

    private

    def validate_params
      Validations::SessionSchema.new.call(params)
    end

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end

    def session
      @session ||= user.sessions.build({ uid: SecureRandom.uuid })
    end
  end
end
