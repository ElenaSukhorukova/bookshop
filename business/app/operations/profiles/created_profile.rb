module Profiles
  class CreatedProfile < Base::MicroCase
    attributes :params

    def call!
      fail_result(msg: I18n.t('erros.invalid_params')) if user.blank?
    end

    private

    def user
      @user ||= User.find_by(id: params[:user_id])
    end
  end
end
