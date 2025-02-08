# frozen_string_literal: true

module User::Authorization
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength
    def remember
      remember_token = generate_token_for(:remember_token)

      self.remember_token = remember_token

      update(remember_digest: User.digest(remember_token))
    end

    def create_reset_digest
      reset_token = generate_token_for(:reset_token)

      $redis.set("#{self.id}_reset_token", reset_token, ex: 15.minutes) # rubocop:disable Style/RedundantSelf

      update(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def authenticated?(attribute, token)
      digest = self.send("#{attribute}_digest") # rubocop:disable Style/RedundantSelf

      return if digest.blank?

      BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
      update(remember_digest: nil)
    end

    def activate
      update(activated: true, activated_at: Time.zone.now)
    end

    def send_activation_email
      UserMailer.with(user: self).account_activation.deliver_later
    end

    def send_password_reset_email
      UserMailer.with(user: self).password_reset.deliver_later
    end

    def create_activate_digest
      activation_token = generate_token_for(:activation_token)

      $redis.set("#{self.id}_activation_token", activation_token, ex: 15.minutes) # rubocop:disable Style/RedundantSelf

      update!(activation_digest: User.digest(activation_token))
    end

    def initiate_activate_process
      create_activate_digest
      send_activation_email
    end

    def initiate_reset_password_process
      create_reset_digest
      send_password_reset_email
    end
  end

  class_methods do
    def digest(string)
      cost = BCrypt::Engine::MIN_COST

      BCrypt::Password.create(string, cost: cost)
    end

    def from_omniauth(auth)
      info = auth.info

      user = find_or_initialize_by(
        uid: auth.uid,
        provider: auth.provider,
        email: info.email
      )

      if user.new_record?
        password = SecureRandom.base64(8)

        user.password = password
        user.password_confirmation = password
        user.provider_settings = { full_name: info.name, avatar_url: info.image }

        user.save

        return user
      end

      user.update(provider_settings: { full_name: info.name, avatar_url: info.image }) if user.provider_settings.blank?

      user
    end
  end
end
