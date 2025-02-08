module Users
  class Activation < Base::MicroCase
    attributes :params

    def call!
      return fail_result(type: :invalide_params, msg: I18n.t('errors.invalid_activation_token')) if user.blank?
      return fail_result(msg: I18n.t('errors.alredy_activated')) if user.activated?

      unless user.authenticated?(:activation, params[:id])
        return fail_result(msg: I18n.t('errors.activation_error', period: count_period))
      end

      ActiveRecord::Base.transaction { user.activate }

      Success result: { msg: I18n.t('operations.activation.activated'), user: user }
    end

    private

    def user
      @user ||= User.find_by_token_for(:activation_token, params[:id])
    end

    def count_period
      15.minutes - (Time.zone.now - user.created_at).ceil.minutes
    end
  end
end
