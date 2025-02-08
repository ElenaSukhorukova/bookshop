# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[omniauth]

  def new
    @session = Session.new
  end

  def create
    operation = Sessions::SessionProcess.call(params: permit_params(:session))

    operation.on_success do |result|
      session = result[:session]
      user = session.user

      sign_in(user, user_session: session)
      remembering_process(user, result[:remember_me])

      redirect_to root_path, success: result[:msg]
    end

    operation.on_failure do |result|
      flash.now[:danger] = result[:msg]

      case result.type
      when :invalid_params
        render :new, status: :unprocessable_entity
      when :unauthorized
        render :new, status: :unauthorized
      else
        render :new, status: :bad_request
      end
    end
  end

  def destroy
    sign_out if signed_in?

    redirect_to root_path
  end

  def omniauth
    Sessions::OmniauthProcess
      .call(params: request.env['omniauth.auth'])
      .on_failure { |result| redirect_to signin_path, danger: result[:msg] }
      .on_success do |result|
        sign_in(result[:user]) if result[:activated]

        redirect_to root_path, info: result[:msg]
      end
  end
end
