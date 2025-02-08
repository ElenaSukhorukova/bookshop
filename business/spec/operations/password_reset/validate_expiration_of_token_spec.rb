require 'rails_helper'

RSpec.describe PasswordReset::ValidateExpirationOfToken do
  include_context 'when activated user is present'

  let(:params) do
    {
      id: 'eyJfcmFpbHMiOnsiZGF0YSI6WzE4LCJHbFdZZ1dObC91Il0sImV'\
      '4cCI6IjIwMjQtMTItMTVUMDc6NDk6MTYuNDcyWiIsInB1ciI6IlV'\
      'zZXJcbnJlc2V0X3Rva2VuXG45MDAifX0=--46ae1ac6cb5297cbf'\
      'd3e04a2f511c2de8081b70f'
    }
  end

  describe '#call' do
    describe 'success process' do
      before do
        allow(User).to receive(:find_by_token_for)
          .with(:reset_token, params[:id])
          .and_return(user)
      end

      it 'validates reset token successfully' do
        operation = described_class.call(params: params)

        expect(operation.data[:user].present?).to be(true)
      end
    end

    it 'validates a blank user' do
      operation = described_class.call(params: params)

      expect(operation.data[:msg]).to include(I18n.t('errors.pass_reset_expired'))
    end
  end
end
