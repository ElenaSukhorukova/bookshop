# frozen_string_literal: true

class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def account_activation
    @user = params[:user]

    @token = $redis.get("#{@user.id}_activation_token")

    mail to: @user.email, subject: t('.subject')
  end

  def password_reset
    @user = params[:user]

    @token = $redis.get("#{@user.id}_reset_token")

    mail to: @user.email, subject: t('.subject')
  end
end
