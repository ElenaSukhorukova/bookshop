class Api::V1::Users::AccountActivationsController < Api::V1::ApplicationController
  def edit
    Users::Activation
      .call(params: { id: params[:id] })
      .on_failure { |result| redirect_to root_path, danger: result[:msg] }
      .on_success do |result|
        sign_in(result[:user])

        redirect_to(new_user_profile_path(result[:user]), success: result[:msg])
      end
  end
end
