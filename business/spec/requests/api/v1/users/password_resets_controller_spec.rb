require 'rails_helper'

RSpec.describe Api::V1::Users::PasswordResetsController, type: :controller do
  include_context 'when it needed headers'
  include_context 'when activated user is present'
  include_context 'when it needs an email and password'

  let(:create_params) do |ex|
    user_email = ex.metadata[:change_email] ? email : user.email

    {
      password_reset: {
        email: user_email
      }
    }
  end

  let(:update_params) do |ex|
    password_confirmation = ex.metadata[:invalid_password] ? user.password : password

    {
      id: token,
      password_reset: {
        email: user.email,
        password: password,
        password_confirmation: password_confirmation
      }
    }
  end

  let(:token) do
    'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
    '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
    'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
    'd3e04a2f511c2de8081b70f'
  end

  before do
    request.headers.merge(header)

    allow(User).to receive(:find_by_token_for).with(:reset_token, token).and_return(user)
    allow(user).to receive(:authenticated?).with(:reset, token).and_return(true)
  end

  describe '#new' do
    it 'shows new template' do
      get :new

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    it 'creates a new reset token' do
      post :create, params: create_params

      expect(subject).to set_flash[:info]
      expect(response).to have_http_status(:found)
      expect(user.reload.reset_digest.present?).to be(true)
    end

    it 'fails to create a new reset token', change_email: true do
      post :create, params: create_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
      expect(subject).to set_flash.now[:danger]
      expect(user.reload.reset_digest.present?).to be(false)
    end
  end

  describe '#edit' do
    it 'shows template' do
      get :edit, params: { id: token }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    before do
      allow(User).to receive(:find_by).with(email: user.email).and_return(user)
    end

    it 'updates password' do
      put :update, params: update_params

      expect(subject).to set_flash[:success]
      expect(response).to have_http_status(:found)
      expect(user.authenticate(password)).to eq(user)
      expect(user.sessions.last.present?).to eq(true)
      expect(session[:session_uid].present?).to be(true)
    end

    it 'fails to update the password', invalid_password: true do
      put :update, params: update_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
      expect(subject).to set_flash.now[:danger]
      expect(user.authenticate(password)).not_to be(user)
    end
  end
end
