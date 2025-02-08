require 'rails_helper'

RSpec.describe Users::Activation do
  let(:user) { create(:user) }

  let(:params) do
    {
      id: token
    }
  end

  let(:token) do
    'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
    '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
    'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
    'd3e04a2f511c2de8081b70f'
  end

  describe '#call' do
    describe 'success process' do
      before do
        allow(User).to receive(:find_by_token_for)
          .with(:activation_token, params[:id])
          .and_return(user)

        allow(user).to receive(:authenticated?)
          .with(:activation, params[:id])
          .and_return(true)
      end

      it 'activates user successfully' do
        operation = described_class.call(params: params)

        expect(operation.data[:user].activated?).to be(true)
        expect(operation.data[:msg]).to include(I18n.t('operations.activation.activated'))
      end
    end

    it 'validates activation_token' do
      operation = described_class.call(params: params)

      expect(operation.type).to be(:invalide_params)
      expect(operation.data[:msg]).to include(I18n.t('errors.invalid_activation_token'))
    end

    describe 'activated error' do
      before do
        allow(User).to receive(:find_by_token_for)
          .with(:activation_token, params[:id])
          .and_return(user)
      end

      it 'validates an activated user' do
        user.update(activated: true)

        operation = described_class.call(params: params)

        expect(operation.data[:msg]).to include(I18n.t('errors.alredy_activated'))
      end

      it 'validates authentication' do
        operation = described_class.call(params: params)

        expect(operation.data[:msg]).to include(I18n.t('errors.activation_error', period: 840))
      end
    end
  end
end
