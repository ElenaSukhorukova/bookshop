require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
  include_context 'when activated user is present'
  include_context 'when it needed headers'

  let(:new_session_params) do |ex|
    password = ex.metadata[:password] || user.password

    {
      session: {
        email: user.email,
        password: password,
        remember_me: '1'
      }
    }
  end

  before do
    request.headers.merge(header)
  end

  describe 'new' do
    it 'shows new template' do
      get :new

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    it 'creates a new session' do
      post :create, params: new_session_params

      user_session = user.sessions.last

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(user_session.created_at.today?).to be(true)
      expect(session[:session_uid]).to eq(user_session.uid)
      expect(cookies[:user_id].present?).to eq(true)
      expect(subject).to set_flash[:success]
    end

    it 'fails to create a new session', password: 'Ol12&*ola19' do
      post :create, params: new_session_params

      expect(response).to have_http_status(:unauthorized)
      expect(response).to render_template(:new)
      expect(subject).to set_flash.now[:danger]
      expect(user.sessions.last).to be(nil)
    end
  end
end
