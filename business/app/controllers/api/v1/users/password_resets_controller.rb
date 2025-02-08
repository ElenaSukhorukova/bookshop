class Api::V1::Users::PasswordResetsController < Api::V1::ApplicationController
  def new; end

  def create
    PasswordReset::InitiatePasswordReset
      .call(params: permit_params(:password_reset))
      .on_success { |result| redirect_to root_path, info: result[:msg] }
      .on_failure do |result|
        flash.now[:danger] = result[:msg]

        case result.type
        when :unactivated_user
          render :new, status: :bad_request
        else
          render :new, status: :unprocessable_entity
        end
      end
  end

  def edit
    PasswordReset::ValidateExpirationOfToken
      .call(params: { id: params[:id] })
      .on_failure { |result| redirect_to new_password_reset_path, danger: result[:msg] }
      .on_success { |result| @user = result[:user] }
  end

  def update
    operation = Users::Updation.call(params: permit_params(:password_reset).merge(id: params[:id]))

    operation.on_failure do |result|
      flash.now[:danger] = result[:msg]

      case result.type
      when :invalid_params
        render :edit, status: :unprocessable_entity
      else
        render :edit, status: :bad_request
      end
    end

    operation.on_success do |result|
      sign_in(result[:user])

      redirect_to root_path, success: result[:msg]
    end
  end
end
