# frozen_string_literal: true

class Api::V1::Users::UsersController < Api::V1::ApplicationController
  def create
    # operation = Users::CreationProcess.call(params: permit_params(:user))

    # operation
    #   .on_success { |result| redirect_to root_path, info: result[:msg] }
    #   .on_failure do |result|
    #     flash.now[:danger] = result[:msg]

    #     @user = result[:user]

    #     case result.type
    #     when :invalid_params
    #       render :new, status: :unprocessable_entity
    #     else
    #       render :new, status: :bad_request
    #     end
    #   end
  end
end
