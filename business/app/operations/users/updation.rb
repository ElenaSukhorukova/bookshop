# frozen_string_literal: true

module Users
  class Updation < Base::MicroCase
    attributes :params

    def call!
      return fail_result(type: :blank_params, msg: I18n.t('errors.blank_params')) if params.blank?
      return fail_result(type: :invalid_params, msg: I18n.t('errors.invalid_email')) if user.blank?

      unless user.authenticated?(:reset, params[:id])
        return fail_result(type: :invalid_params, msg: I18n.t('errors.invalid_token'))
      end

      validation = validate_params

      unless validation.success?
        return fail_result(type: :invalid_params,
                           msg: validation.errors(full: true).to_h.values.flatten.join('; '))
      end

      unless user.update(params_for_updation)
        return fail_result(type: :invalid_params,
                            msg: user.errors.full_messages.join('; '))
      end

      Success result: { user: user, msg: I18n.t('operations.updation.password_reset') }
    end

    private

    def validate_params
      Validations::EditUserSchema.new.call(params)
    end

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end

    def params_for_updation
      {
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      }
    end
  end
end
