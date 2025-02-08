require 'rails_helper'

RSpec.describe Api::V1::Users::UsersController, type: :controller do
  include_context 'when it needed headers'
  include_context 'when it needs an email and password'

  let(:new_user_params) do
    {
      user: {
        email: email,
        password: password,
        password_confirmation: password,
        role: 'customer'
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
    it 'creates a new user' do
      post :create, params: new_user_params

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
      expect(User.find_by(email: email).present?).to be(true)
      expect(subject).to set_flash[:info]
    end

    it 'fails to create a new user' do
      new_user_params[:user][:password] = new_user_params.dig(:user, :email)

      post :create, params: new_user_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
      expect(subject).to set_flash.now[:danger]
      expect(User.find_by(email: email).present?).to be(false)
    end
  end
end
