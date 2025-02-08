module Authorization
  extend ActiveSupport::Concern

  EXPIRING_TURM = 24.hours
  REMEMBER_VALUE = '1'

  included do # rubocop:disable Metrics/BlockLength
    include ActionController::Cookies

    helper_method :current_user

    private

    def sign_in(user, user_session: nil)
      user_session ||= user.sessions.create(session_params)

      return if user_session.blank?

      session[:session_uid] = user_session.uid
      session[:expiring_date] = Time.zone.now + EXPIRING_TURM
    end

    def current_user # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      sign_out_by_session if session[:expiring_date].try(:<, Time.zone.now)

      user_session = define_user_session(session[:session_uid])

      if user_session.present? && (session_user_id = user_session.user.id)
        @current_user ||= User.find(session_user_id)
      end

      if @current_user.blank? && (cookies_user_id = cookies.signed[:user_id])
        user = User.find(cookies_user_id)

        if user.present? && user.authenticated?(:remember, cookies[:remember_token])
          sign_in(user)

          @current_user ||= user
        end
      end

      @current_user
    end

    def signed_in?
      current_user.present?
    end

    def sign_out
      forget(current_user) if current_user.present?

      sign_out_by_session

      @current_user = nil
    end

    def sign_out_by_session
      session.delete(:session_uid)
      session.delete(:expires_in)
    end

    def remembering_process(user, remember_me)
      remember_me == REMEMBER_VALUE ? remember(user) : forget(user)
    end

    def remember(user)
      user.remember

      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end

    def forget(user)
      user.forget

      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    def session_params
      { uid: SecureRandom.uuid }
    end

    def define_user_session(session_uid)
      Session.find_by(uid: session_uid)
    end
  end
end
