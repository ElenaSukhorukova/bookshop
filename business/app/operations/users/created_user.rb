# frozen_string_literal: true

module Users
  class CreatedUser < Base::MicroCase
    WATING_MINUTES = 15.minutes

    attributes :params

    def call!
      return fail_result(type: :blank_params, msg: I18n.t('errors.blank_params')) if params.blank?

      validation = validate_params

      unless validation.success?
        return fail_result( user: user,
                            type: :invalid_params,
                            msg: validation.errors(full: true).to_h.values.flatten.join('; ') )
      end

      unless user.save
        return fail_result( user: user,
                            type: :invalid_params,
                            msg: user.errors.full_messages.join('; ') )
      end

      DeletionUnactivatedUserWorker.perform_in(WATING_MINUTES, user.id)

      Success result: { user: user }
    end

    private

    def validate_params
      Validations::UserSchema.new.call(params)
    end

    def user
      @user ||= User.new(params)
    end
  end
end
