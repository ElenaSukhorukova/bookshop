require 'rails_helper'

RSpec.describe Api::V1::Users::AccountActivationsController, type: :controller do
  include_context 'when it needed headers'

  let(:user) { create(:user) }
  let(:activation_params) do
    {
      id: 'eyJfcmFpbHMiOnsiZGF0YSI6WzE3XSwiZXhwIjoiMjAyNC0xMi0xM1QwMzozND'\
          'o1NS4zNzZaIiwicHVyIjoiVXNlclxuYWN0aXZhdGlvbl90b2tlblxuOTAwIn19-'\
          '-02e01d2501e157408fb7a56d9657bee7094cbc2b'
    }
  end

  before do
    request.headers.merge(header)
  end

  describe 'success request' do
    before do
      allow(User).to receive(:find_by_token_for)
        .with(:activation_token, activation_params[:id])
        .and_return(user)

      allow(user).to receive(:authenticated?).and_return(true)
    end

    it 'activates the user' do
      get :edit, params: activation_params

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_profile_path(user))
      expect(user.activated?).to be(true)
      expect(session[:session_uid].present?).to be(true)
      expect(subject).to set_flash[:success]
    end
  end

  describe 'failed request' do
    it 'redirets to root_path' do
      get :edit, params: activation_params

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(user.activated?).to be(false)
      expect(subject).to set_flash[:danger]
    end
  end
end
